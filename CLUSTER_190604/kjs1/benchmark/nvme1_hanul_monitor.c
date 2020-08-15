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
	
char* file[10];

float threshold_per;
float write_per;
	
int breakpoint=0;


int
main (int argc, char *argv[])
{
	int nummigrator = 2;
	threshold_per = atof(argv[2]);
	write_per = atof(argv[3]);

	file[1]='\0';
	file[2]='\0';
	//monitor_breakpoint();	
	migrator_create(nummigrator, argv[1]);

	return 0;
}

/*
int monitor_breakpoint()
{
	FILE *fp;
	char perf[10];
	float fperf;
	int toggle=0;

	while(1){
		fp = popen("iostat -d nvme2n1 1 2 | tail -n 2 | awk '{print $4}'", "r");
		if(fgets(perf, sizeof(perf)-1, fp) != NULL) {
			fperf = atof(perf);
			if(fperf == 0)
				toggle++;
			else
				toggle=0;
			if(toggle>=3){
				breakpoint=1;
				//printf("BREAKPOINT\n");
			}
		}
		pclose(fp);
	}

	return 0;
}
*/
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
		//pthread_cond_wait(&cond[num], &mutex[num]);
		//migrate from nvme to ssd
		if(file[num] != NULL) {
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
			printf("[%d]DO_MIGRATE: %s\n", num, cmd);
			status = system(cmd); // finish copy

			strcpy(cmd, "rm -rf ");
			strcat(cmd, reply->str);
			strcat(cmd, "/");
			strcat(cmd, FILENAME);
			printf("[%d]DO_MIGRATE: %s\n", num, cmd);
			status = system(cmd); // finish remove base file
			system("find /mnt/nvme1n1/.glusterfs/ -type f -links -2 ! -path '/mnt/nvme1n1/.glusterfs/health_check' -exec rm {} +");

			freeReplyObject(reply);
			//MIGRATE FROM NVME TO SSD
			reply = redisCommand(c, "SET %s %s", TEMP, "/mnt/cold");
			freeReplyObject(reply);

			free(file[num]);
			file[num]='\0';
		}
		//printf("%d: do_migrate\n", num);
		//pthread_mutex_unlock(&mutex[num]);
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

	redisReply *reply6;
	unsigned int j, k, m;
	char APPID[100] = "";
	char VERSIONID[100] = "";
	char* FILENAME;
	char* cmd = (char *)malloc(sizeof(char) * 100);
	int status = 0;
	char TEMP[100] = "";

	int thr_id=0;
	int migrate=0;

	for(i=1; i<3; i++){
		pthread_mutex_init(&mutex[name+i], NULL);
		pthread_cond_init(&cond[name+i], NULL);
		thr_id = pthread_create(&p_thread, NULL, do_migrate, name+i);
		if(thr_id < 0)
			perror("error sub migrator creation\n");
	}


	while(1) {
			reply = redisCommand(c, "ZREVRANGE %s 0 -1", "LRU");
			if(reply->type == REDIS_REPLY_ARRAY) {
					//printf("NUMBER OF LRU ELEMENT:%d\n", reply->elements);
					for(j=0; j<reply->elements; j++) {
							if (strcmp(reply->element[j]->str, "") != 0){
									//printf("%dth out of %d APP\n", j, reply->elements);
									strcpy(APPID, reply->element[j]->str);
									strcpy(VERSIONID, APPID);
									strcat(VERSIONID, "VER.");
									reply2 = redisCommand(c, "HGET %s VERSION", APPID);
									strcat(VERSIONID, reply2->str);
									strcat(VERSIONID, "/mnt/nvme1n1");
									freeReplyObject(reply2);
									
									//printf("VERSIONID:%s\n", VERSIONID);
									reply2 = redisCommand(c, "LRANGE %s 0 -1", VERSIONID);
									if(reply2->type == REDIS_REPLY_ARRAY) {
											for(k=0; k<reply2->elements; k++) {
													if (reply2->element[k]->str != NULL) {
															strcpy(TEMP, reply2->element[k]->str);
															reply5 = redisCommand(c, "GET %s", TEMP);
															if(strcmp(reply5->str, "/mnt/cold") != 0){
																	//printf("GOING TO WHILE LOOP-- k:%d file:%s\n", k, reply2->element[k]->str);
																	//printf("CURRENT-- file[1]:%s file[2]:%s\n", file[1], file[2]);
																	while(1)
																	{
																			//if(file[1] == NULL && strcmp(file[2], reply2->element[k]->str) != 0)
																			if(file[1] == NULL)
																			{
																					//printf("GIVING FILE[1]\n");
																					//file[1] = (char *)malloc(sizeof(char) * strlen(reply2->element[k]->str));
																					file[1] = (char *)malloc(sizeof(char) * 100);
																					strcpy(file[1], reply2->element[k]->str);
																					//pthread_cond_signal(&cond[1]);
																					break;
																			}
																			//if(file[2] == NULL && strcmp(file[1], reply2->element[k]->str) != 0)
																			if(file[2] == NULL)
																			{
																					//printf("GIVING FILE[2]\n");
																					//file[2] = (char *)malloc(sizeof(char) * strlen(reply2->element[k]->str));
																					file[2] = (char *)malloc(sizeof(char) * 100);
																					strcpy(file[2], reply2->element[k]->str);
																					//pthread_cond_signal(&cond[2]);
																					break;
																			}
																	}
															}
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
	//int sp[10] = { 715, 558, 323, 86, 657, 554, 457, 363, 270, 177 };
	int sp[10] = { 545, 427, 240, 61, 499, 423, 346, 278, 202, 134 };
	char *goal[10] = { "1.0tb", "1.1tb", "1.2tb", "1.3tb", "1.4tb", "1.5tb", "1.6tb", "1.7tb", "1.8tb", "1.9tb" };
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
	FILE *fp_;
	char space[10];
	char space_[10];
	//char *TEMP;
	char TEMP[100];
	char TEMP_[100];
	float m, b, write;
	char writeP[10];
	//int intspace, threshold;
	int intspace;
	float threshold;
	int low = 0;

	FILE *fp2;
	char perf[10];
	float fperf;
	int toggle=0;

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
	reply = redisCommand(c, "SET %s %d", "MIGRATE", 0);
	freeReplyObject(reply);


	for(i = 0; i < 10; i++) {
		if(strcmp(input, goal[i]) == 0){
			threshold = sp[i];
			if(i < 4)
				low = 1;
			break;
		}
	}

	if(strcmp(input, "0.0tb") != 0){ // when migration is needed
		//for(i = 0; i < nummigrator; i++)
		
		for(i = 0; i < 1; i++)
		{	
			thr_id = pthread_create(&p_thread[i], NULL, do_main_migrate, (void *)i);
			//printf("JW/// migrator thread:%d created\n", i); 

			if(thr_id  < 0)
			{
				perror("migrator thread create error\n");
			}
		}

		//adaptive
		int tog = 0;
		printf("threshold:%lf\n", threshold);
		while(1) {
			//TEMP = (char *)malloc(sizeof(char)*100);
			fp2 = popen("iostat -d md2 1 2 | tail -n 2 | awk '{print $4}'", "r");
			if(fgets(perf, sizeof(perf)-1, fp2) != NULL) {
				fperf = atof(perf);
				//printf("==================================nvme3n1 performance:%lf\n", fperf);
				if(fperf < 10000)
					tog++;
				else
					tog=0;

				if(tog>=3)
					breakpoint=1;
				else
					breakpoint=0;
			}
			pclose(fp2);

			if(breakpoint) {
				printf("breakpoint....read to 450\n");
				strcpy(command, "sh /home/dcslab/benchmark/read_1.sh 450");
				system(command);
			}
			else{
				strcpy(TEMP, "df -h ");
				strcat(TEMP, "/dev/md2");
				strcat(TEMP, " | awk '{ print $3 }' | tail -n 1");
				fp = popen(TEMP, "r");
				if(fgets(space, sizeof(space)-1, fp) != NULL){
					strcpy(TEMP_, "df -h ");
					strcat(TEMP_, "/dev/sdi");
					strcat(TEMP_, " | awk '{ print $3 }' | tail -n 1");
					fp_ = popen(TEMP_, "r");
					if(fgets(space_, sizeof(space_)-1, fp_) != NULL){
						if(space_[strlen(space_)-2] == 'M')
							intspace = 0;
						else
							intspace = atoi(space_);
					}
					pclose(fp_);

					if(space[strlen(space)-2] == 'M')
						intspace += 0;
					else
						intspace += atoi(space);
					
					if(intspace >= 550)
						intspace = 550;
					printf("CURRENT SPACE: %dG\n", intspace);

					
					//if(intspace < 700 && toggle == 1)
					//	toggle = 0;
					//if(intspace >= 720)
					//	toggle = 1;
					


					//if(toggle){	//nvme is full
					//	strcpy(command, readwrite[2]);
					//	strcat(command, "5");
					//	system(command);
					//}
					//else {
							

						if(low) {
							if(intspace < threshold){
								strcpy(command, readwrite[1]);
								strcat(command, "890");
								system(command);
								//printf("[1]:%d\n", intspace);
							}
							else{
								m = (765-890) / (float)(1000-threshold);
								b = 765 - 1000 * m;
								write = (float)m * intspace + b;
								strcpy(command, readwrite[1]);
								sprintf(writeP, "%g", write);
								strcat(command, writeP);
								system(command);
								//printf("[2]:%d\n", intspace);
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
								//printf("[3]:%d\n", intspace);
							}
							else {
								strcpy(command, readwrite[1]);
								strcat(command, "765");
								system(command);
								//printf("[4]:%d\n", intspace);
							}
						}
					//}
				}
				pclose(fp);
			}
			//free(TEMP);
			sleep(1);
		}
		
		for(i = 0; i < 5; i++)
		{
			pthread_join(p_thread[i], (void **)&status);	
		}

		pthread_mutex_destroy(&mutex);
		//for(i = 0; i < MAX_MIGRATORS; i++)
		for(i = 0 ; i < 5; i++)
		{
			pthread_mutex_destroy(&mutex[i]);
			pthread_cond_destroy(&cond[i]);
		}
	}


	return 0;
}


