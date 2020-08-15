// gcc monitor.c -o migrator -lpthread -lhiredis

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <hiredis.h>

#define NUM_DEVICES 4
#define MAX_MIGRATORS 8

int device[NUM_DEVICES];
pthread_mutex_t mutex[MAX_MIGRATORS * NUM_DEVICES]; 
pthread_cond_t cond[MAX_MIGRATORS * NUM_DEVICES];
	
char* file;

float threshold_per;
float write_per;
	
int
main (int argc, char *argv[])
{
	int nummigrator = 2;
	threshold_per = atof(argv[2]);
	write_per = atof(argv[3]);

	migrator_create(nummigrator, argv[1]);

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
	
	printf("BANG:do_migrate[%d]\n", num);
	while(1)
	{
		pthread_cond_wait(&cond[num], &mutex[num]);
		//migrate from nvme to ssd
		if(file != NULL) {
			strcpy(TEMP, file);
			FILENAME = strtok(file, "/");
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

			strcpy(cmd, "rm -rf ");
			strcat(cmd, reply->str);
			strcat(cmd, "/");
			strcat(cmd, FILENAME);
			printf("DO_MIGRATE: %s\n", cmd);
			status = system(cmd); // finish remove base file
			system("find /mnt/nvme3n1/.glusterfs/ -type f -links -2 -exec rm {} +");

			freeReplyObject(reply);
			//MIGRATE FROM NVME TO SSD
			reply = redisCommand(c, "SET %s %s", TEMP, "/mnt/cold");
			freeReplyObject(reply);
		}
		//printf("%d: do_migrate\n", num);
		pthread_mutex_unlock(&mutex[num]);
	}

	redisFree(c);
	return 0;
}


int do_main_migrate(int name)
{
	char* BASENAME[4] = {"/mnt/nvme0n1", "/mnt/nvme1n1", "/mnt/nvme3n1", "/mnt/nvme4n1"};


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

	//printf("BANG:do_main_migrate[%d] : BASENAME:%s\n", name, BASENAME[name%4]);
	printf("BANG:do_main_migrate[%d]\n", name);


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

	pthread_mutex_init(&mutex[1], NULL);
	pthread_cond_init(&cond[1], NULL);
	int thr_id = pthread_create(&p_thread, NULL, do_migrate, 1);
	if(thr_id < 0)
		perror("error sub migrator creation\n");

	
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
					strcat(VERSIONID, "/mnt/nvme3n1");
					freeReplyObject(reply2);

					reply2 = redisCommand(c, "LRANGE %s 0 -1", VERSIONID);
					if(reply2->type == REDIS_REPLY_ARRAY) {
						for(k=0; k<reply2->elements; k++) {
							if (reply2->element[k]->str != NULL) {
								strcpy(TEMP, reply2->element[k]->str);
								reply5 = redisCommand(c, "GET %s", TEMP);
								if(strcmp(reply5->str, "/mnt/cold") != 0){
									
									if(k+1 < reply2->elements && reply2->element[k+1]->str != NULL){
										file = (char *)malloc(sizeof(char) * strlen(reply2->element[k+1]->str));
										strcpy(file, reply2->element[k+1]->str);
										pthread_cond_signal(&cond[1]);
									}
									FILENAME = strtok(reply2->element[k]->str, "/");
									FILENAME = strtok(NULL, "/");
									strcpy(cmd, "/home/dcslab/benchmark/64M_sendfile_benchmark ");
									strcat(cmd, "/mnt/nvme3n1");
									strcat(cmd, "/");
									strcat(cmd, FILENAME);
									strcat(cmd, " /mnt/cold/");
									strcat(cmd, FILENAME);
									printf("MAIN MIGRATE :%s\n", cmd);
									status = system(cmd); // finish copy
									
									strcpy(cmd, "rm -rf ");
									strcat(cmd, "/mnt/nvme3n1");
									strcat(cmd, "/");
									strcat(cmd, FILENAME);
									printf("MAIN MIGRATE :%s\n", cmd);
									status = system(cmd); // finish remove base file
									system("find /mnt/nvme3n1/.glusterfs/ -type f -links -2 -exec rm {} +");

									//MIGRATE FROM NVME TO SSD
									reply3 = redisCommand(c, "SET %s %s", TEMP, "/mnt/cold");
									freeReplyObject(reply3);

									k += 1;
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
	}


	redisFree(c);
	return 0;

}

int migrator_create(int nummigrator, char* input)
{
	pthread_t p_thread[nummigrator];
	int thr_id;
	int status;

	int i;
	int sp[10] = { 618, 466, 314, 162, 10, 648, 566, 484, 403, 321 };
	char *goal[10] = { "1.1tb", "1.2tb", "1.3tb", "1.4tb", "1.5tb", "1.6tb", "1.7tb", "1.8tb", "1.9tb", "2.0tb" };
	char *basename[4] = {"/dev/nvme0n1", "/dev/nvme1n1", "/dev/nvme3n1", "/dev/nvme4n1"};
	char *readwrite[4] = {
		"sh /home/dcslab/benchmark/readwrite_0.sh ",
		"sh /home/dcslab/benchmark/readwrite_1.sh ",
		"sh /home/dcslab/benchmark/readwrite_2.sh ",
		"sh /home/dcslab/benchmark/readwrite_3.sh "
	};
	char command[100];
	//char *command = (char *)malloc(sizeof(char) * 100);

	FILE *fp;
	char space[10];
	//char *TEMP;
	char TEMP[100];
	float m, b, write;
	char writeP[10];
	//int intspace, threshold;
	int intspace;
	float threshold;
	int low = 0;



	for(i = 0; i < 10; i++) {
		if(strcmp(input, goal[i]) == 0){
			threshold = sp[i];
			if(i < 5)
				low = 1;
			break;
		}
	}

	if(strcmp(input, "1.0tb") != 0){ // when migration is needed
		//for(i = 0; i < nummigrator; i++)
		/*
		for(i = 0; i < 1; i++)
		{	
			thr_id = pthread_create(&p_thread[i], NULL, do_main_migrate, (void *)i);
			if(thr_id  < 0)
			{
				perror("migrator thread create error\n");
			}
		}
		*/

		//static
		threshold = (float)720 * threshold_per;
		//printf("threshold_per:%lf, threshold:%lf\n", threshold_per, threshold);
		int toggle = 0;
		while(1) {
			strcpy(TEMP, "df -h ");
			strcat(TEMP, "/dev/nvme3n1");
			strcat(TEMP, " | awk '{ print $3 }' | tail -n 1");
			fp = popen(TEMP, "r");
			if(fgets(space, sizeof(space)-1, fp) != NULL){
				if(space[strlen(space)-2] == 'M')
					intspace = 0;
				else
					intspace = atoi(space);
	
				if(intspace < 700 && toggle == 1)
					toggle = 0;
				if(intspace >= 720)
					toggle = 1;

				//if(toggle){	//nvme is full
				//	strcpy(command, readwrite[2]);
				//	strcat(command, "5");
				//	system(command);
				//}
				else {
					if (intspace < threshold){
						strcpy(command, readwrite[2]);
						strcat(command, "890");
						system(command);
					}
					else {
						write = (float)890 * write_per;
						strcpy(command, readwrite[2]);
						sprintf(writeP, "%g", write);
						strcat(command, writeP);
						system(command);
					}
				}
			}
			pclose(fp);
			sleep(1);
		}

		//adaptive
		/*
		while(1) {
			//TEMP = (char *)malloc(sizeof(char)*100);
			strcpy(TEMP, "df -h ");
			strcat(TEMP, "/dev/nvme1n1");
			strcat(TEMP, " | awk '{ print $3 }' | tail -n 1");
			fp = popen(TEMP, "r");
			if(fgets(space, sizeof(space)-1, fp) != NULL){
				if(space[strlen(space)-2] == 'M')
					intspace = 0;
				else
					//else if (space[strlen(space)-2] == 'G')
					intspace = atoi(space);
				if(low) {
					if(intspace < threshold){
						strcpy(command, readwrite[1]);
						strcat(command, "890");
						system(command);
						//printf("[1]:%s\n", command);
					}
					else{
						m = (765-890) / (float)(1000-threshold);
						b = 765 - 1000 * m;
						write = (float)m * intspace + b;
						strcpy(command, readwrite[1]);
						sprintf(writeP, "%g", write);
						strcat(command, writeP);
						system(command);
						//printf("[2]:%s\n", command);
					}
				}
				else {
					if(intspace < threshold){
						m = (765-890) / (float)threshold;
						b = 890;
						write = (float)m * intspace + b;
						strcpy(command, readwrite[1]);
						sprintf(writeP, "%g", write);
						strcat(command, writeP);
						system(command);
						//printf("[3]:%s\n", command);
					}
					else {
						strcpy(command, readwrite[1]);
						strcat(command, "765");
						system(command);
						//printf("[4]:%s\n", command);
					}
				}
			}
			pclose(fp);
			//free(TEMP);
			sleep(1);
		}
*/
/*
		while(1) {
			for(i = 0; i < NUM_DEVICES; i++){
				strcpy(TEMP, "df -h ");
				strcat(TEMP, basename[i]);
				strcat(TEMP, " | awk '{ print $3 }' | tail -n 1");
				fp = popen(TEMP, "r");
				if(fgets(space, sizeof(space)-1, fp) != NULL){
					if(space[strlen(space)-2] == 'M')
						intspace = 0;
					else
					//else if (space[strlen(space)-2] == 'G')
						intspace = atoi(space);
					if(low) {
						if(intspace < threshold){
							strcpy(command, readwrite[i]);
							strcat(command, "890");
							system(command);
							//printf("[1]:%s\n", command);
						}
						else{
							m = (765-890) / (float)(1000-threshold);
							b = 765 - 1000 * m;
							write = (float)m * intspace + b;
							strcpy(command, readwrite[i]);
							sprintf(writeP, "%g", write);
							strcat(command, writeP);
							system(command);
							//printf("[2]:%s\n", command);
						}
					}
					else {
						if(intspace < threshold){
							m = (765-890) / (float)threshold;
							b = 890;
							write = (float)m * intspace + b;
							strcpy(command, readwrite[i]);
							sprintf(writeP, "%g", write);
							strcat(command, writeP);
							system(command);
							//printf("[3]:%s\n", command);
						}
						else {
							strcpy(command, readwrite[i]);
							strcat(command, "765");
							system(command);
							//printf("[4]:%s\n", command);
						}
					}
				}
				close(fp);
			}
			sleep(1);
		}
		*/
		
		
		/*
		for(i = 0; i < 2; i++)
		{
			pthread_join(p_thread[i], (void **)&status);	
		}

		pthread_mutex_destroy(&mutex);
		*/
		
		
		
		//for(i = 0; i < MAX_MIGRATORS; i++)
		
		/*
		for(i = 0 ; i < 2; i++)
		{
			pthread_mutex_destroy(&mutex[i]);
			pthread_cond_destroy(&cond[i]);
		}
		*/
	}


	return 0;
}


