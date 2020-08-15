// gcc monitor.c -o migrator -lpthread -lhiredis

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <hiredis.h>

#define NUM_DEVICES 4
#define MAX_MIGRATORS 4

int device[NUM_DEVICES];
pthread_mutex_t mutex[MAX_MIGRATORS * NUM_DEVICES]; 
pthread_cond_t cond[MAX_MIGRATORS * NUM_DEVICES];
	
char* file[4];

int
main (int argc, char *argv[])
{
	int nummigrator = 4;
	int i;
	for(i = 0; i < NUM_DEVICES; i++)
		device[i]= 0;
	monitor_create();
	migrator_create(nummigrator);

	return 0;
}

int do_monitor(char* name)
{
	FILE *diskstatfile = NULL;
	
	while(1)
	{
		diskstatfile = fopen("/proc/diskstats", "r");
		if(diskstatfile != NULL)
		{
			
			char strTemp[255];
			int i,j;
			char *qLen = NULL;
			char *token = " ";
			for(i = 0; i < 4; i++) 
			{
				j = 0;
				fgets(strTemp, sizeof(strTemp), diskstatfile);
				qLen = strtok(strTemp, token);	
				while (qLen)
				{
					if(j == 11)
					{
						//calculating the number of migrators
						device[i] = atoi(qLen);
						break;
					}
					qLen = strtok(NULL, token);
					j++;
				}
			}
		}
		fclose(diskstatfile);
	}
	return 0;
}

int monitor_create()
{
	pthread_t p_thread[1];
	int thr_id;

	thr_id = pthread_create(&p_thread, NULL, do_monitor, "monitor");
	//printf("JW/// monitor thread:%d created\n", thr_id); 
	if(thr_id < 0)
		perror("monitor create error\n");
	
	return 0;
}

int do_migrate(int num)
{
	int status;
	char* FILENAME;
	char TEMP[100] = "";
	char* cmd = (char *)malloc(sizeof(char) * 100);
	redisReply *reply;

	struct timeval timeout = {1, 500000};
	redisContext *c = redisConnectWithTimeout("127.0.0.1", 6379, timeout);
	if (c == NULL || c->err) {
		if (c) {
			perror("connection error");
			redisFree(c);
		}
		else
			perror("connection error: can't allocate redis context");
	}
	
	while(1)
	{
		pthread_cond_wait(&cond[num], &mutex[num]);
		//migrate from nvme to ssd
		strcpy(TEMP, file[num]);
		FILENAME = strtok(file[num], "/");
		FILENAME = strtok(NULL, "/");
		strcpy(cmd, "/home/dcslab/benchmark/64M_sendfile_benchmark ");
		reply = redisCommand(c, "GET %s", TEMP);
		strcat(cmd, reply->str);
		strcat(cmd, "/");
		strcat(cmd, FILENAME);
		strcat(cmd, " /mnt/cold/");
		strcat(cmd, FILENAME);
		printf("DO_MIGRATE: %s\n", cmd);
		status = system(cmd); // finish copy

		strcpy(cmd, "rm ");
		strcat(cmd, reply->str);
		strcat(cmd, "/");
		strcat(cmd, FILENAME);
		printf("DO_MIGRATE: %s\n", cmd);
		status = system(cmd); // finish remove base file

		freeReplyObject(reply);
		//MIGRATE FROM NVME TO SSD
		reply = redisCommand(c, "SET %s %s", TEMP, "/mnt/cold");
		freeReplyObject(reply);

		//printf("%d: do_migrate\n", num);
		pthread_mutex_unlock(&mutex[num]);
	}

	redisFree(c);
	return 0;
}

int do_main_migrate(int name)
{
	char* BASENAME[4] = {"/mnt/nvme0n1", "/mnt/nvme2n1", "/mnt/nvme3n1", "/mnt/nvme4n1"};


	struct timeval timeout = {1, 500000};
	redisContext *c = redisConnectWithTimeout("127.0.0.1", 6379, timeout);
	if (c == NULL || c->err) {
		if (c) {
			perror("connection error");
			redisFree(c);
		}
		else
			perror("connection error: can't allocate redis context");
	}
	//Connection established

	int migrator_name = (int) name;
	//printf("[%d] pid:%u, tid:%u \n", name, getpid(), pthread_self());

	pthread_t p_thread[MAX_MIGRATORS];
	
	int i, l;


	redisReply *reply;
	redisReply *reply2;
	redisReply *reply3;
	redisReply *reply4;
	redisReply *reply5;
	unsigned int j, k, m;
	char APPID[100] = "";
	char VERSIONID[100] = "";
	char* FILENAME;
	char* cmd = (char *)malloc(sizeof(char) * 100);
	int status = 0;
	char TEMP[100] = "";

	for(i = 0; i < MAX_MIGRATORS; i++)
	{
		pthread_mutex_init(&mutex[name*NUM_DEVICES+i], NULL);
		pthread_cond_init(&cond[name*NUM_DEVICES+i], NULL);
	}
	for(i = 0; i < MAX_MIGRATORS; i++)
	{
		int thr_id;
		thr_id = pthread_create(&p_thread, NULL, do_migrate, name*NUM_DEVICES+i);
		if(thr_id < 0)
			perror("error sub migrator creation\n");
	}

	while(1)
	{
		reply = redisCommand(c, "ZREVRANGE %s 0 -1", "LRU");
		if(reply->type == REDIS_REPLY_ARRAY) {
			for(j=0; j<reply->elements; j++) {
				if (strcmp(reply->element[j]->str, "") != 0){
					strcpy(APPID, reply->element[j]->str);
					strcpy(VERSIONID, APPID);
					strcat(VERSIONID, "VER.");
					reply2 = redisCommand(c, "HGET %s VERSION", APPID);
					strcat(VERSIONID, reply2->str);
					strcat(VERSIONID, BASENAME[name]); //IS THIS RIGHT?
					freeReplyObject(reply2);

					reply2 = redisCommand(c, "LRANGE %s 0 -1", VERSIONID);
					if(reply2->type == REDIS_REPLY_ARRAY) {
						for(k=0; k<reply2->elements; k++) {
							if (reply2->element[k]->str != NULL) {
								strcpy(TEMP, reply2->element[k]->str);
								reply5 = redisCommand(c, "GET %s", TEMP);
								if(strcmp(reply5->str, "/mnt/cold") != 0){
									//printf("IN THE NVME : %s\n", TEMP);
									if(device[name] == 1) {
										FILENAME = strtok(reply2->element[k]->str, "/");
										FILENAME = strtok(NULL, "/");
										strcpy(cmd, "/home/dcslab/benchmark/64M_sendfile_benchmark ");
										strcat(cmd, BASENAME[name]);
										strcat(cmd, "/");
										strcat(cmd, FILENAME);
										strcat(cmd, " /mnt/cold/");
										strcat(cmd, FILENAME);
										printf("single MAIN MIGRATE :%s\n", cmd);
										status = system(cmd); // finish copy

										strcpy(cmd, "rm ");
										strcat(cmd, BASENAME[name]);
										strcat(cmd, "/");
										strcat(cmd, FILENAME);
										printf("single MAIN MIGRATE :%s\n", cmd);
										status = system(cmd); // finish remove base file

										//MIGRATE FROM NVME TO SSD
										reply3 = redisCommand(c, "SET %s %s", TEMP, "/mnt/cold");
										freeReplyObject(reply3);
									}
									else {
										for (i = 0; i < (device[name] - 1); i++)
										{
											if (k+1+i < reply2->elements && reply2->element[k+1+i]->str != NULL){
												file[name*NUM_DEVICES+i] = (char *)malloc(sizeof(char) * strlen(reply2->element[k+1+i]->str));
												strcpy(file[name*NUM_DEVICES+i], reply2->element[k+1+i]->str);
												//printf("GIVE FILE ARRAY IDX %d, file %s\n", name*NUM_DEVICES+i, reply2->element[k+1+i]->str);
												pthread_cond_signal(&cond[name*NUM_DEVICES+i]);
											}
										}
										FILENAME = strtok(reply2->element[k]->str, "/");
										FILENAME = strtok(NULL, "/");
										strcpy(cmd, "/home/dcslab/benchmark/64M_sendfile_benchmark ");
										strcat(cmd, BASENAME[name]);
										strcat(cmd, "/");
										strcat(cmd, FILENAME);
										strcat(cmd, " /mnt/cold/");
										strcat(cmd, FILENAME);
										printf("multi MAIN MIGRATE :%s\n", cmd);
										status = system(cmd); // finish copy

										strcpy(cmd, "rm ");
										strcat(cmd, BASENAME[name]);
										strcat(cmd, "/");
										strcat(cmd, FILENAME);
										printf("multi MAIN MIGRATE :%s\n", cmd);
										status = system(cmd); // finish remove base file

										//MIGRATE FROM NVME TO SSD
										reply3 = redisCommand(c, "SET %s %s", TEMP, "/mnt/cold");
										freeReplyObject(reply3);

										k += i;
										i=0;
									}
								}
								//else 
								//	printf("IN THE SSD : %s\n", TEMP);
								freeReplyObject(reply5);
							}
						}
					}
					freeReplyObject(reply2);

				}
			}
		}
		freeReplyObject(reply);
		/*
		   if(device[name] == 1)
		   {
		//get name of files for migration
		//after migration, set new location of the files 

		printf("only migrate alone\n");
		}else 
		{				
			int i;
			for(i = 0; i < (device[name]-1); i++)
			{
				pthread_cond_signal(&cond[name*NUM_DEVICES+i]);
			}
		}*/	
	}


	redisFree(c);
	return 0;

}

int migrator_create(int nummigrator)
{
	pthread_t p_thread[nummigrator];
	int thr_id;
	int status;

	int i;
	for(i = 0; i < nummigrator; i++)
	{	
		thr_id = pthread_create(&p_thread[i], NULL, do_main_migrate, (void *)i);
		//printf("JW/// migrator thread:%d created\n", i); 

		if(thr_id  < 0)
		{
			perror("migrator thread create error\n");
		}
	}
	
	for(i = 0; i < 21; i++)
	{
		pthread_join(p_thread[i], (void **)&status);	
	}

	pthread_mutex_destroy(&mutex);
	for(i = 0; i < MAX_MIGRATORS; i++)
	{
		pthread_mutex_destroy(&mutex[i]);
		pthread_cond_destroy(&cond[i]);
	}

	return 0;
}


