// gcc monitor.c -o migrator -lpthread -lhiredis

#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <hiredis.h>


int
main (int argc, char *argv[])
{
	redisContext *c;
	redisReply *reply;
	redisReply *reply2;
	redisReply *temp;
	int i, j;
	char *APPID[200];
	char VERSIONID[100] = "";
	float score[200];

	float sum=0;
	int len=0;
	float random;

	struct timeval timeout = { 1, 500000 };
	c = redisConnectWithTimeout ("127.0.0.1", 6379, timeout);
	if (c == NULL || c->err) {
		if(c) {
			perror("connection error");
			redisFree(c);
		}
		else
			perror("connection error: can't allocate redis context");
	}

	reply = redisCommand(c, "ZREM %s %s", "MTBF", "");
	freeReplyObject(reply);
	reply = redisCommand(c, "ZRANGE %s 0 -1", "MTBF");
	if(reply->type == REDIS_REPLY_ARRAY) {
		for(i=0; i<reply->elements; i++) {
			if(strcmp(reply->element[i]->str, "") != 0){
				APPID[i] = (char *)malloc(sizeof(char) * strlen(reply->element[i]->str));
				//printf("[%d] %s\n", i, reply->element[i]->str);
				strcpy(APPID[i], reply->element[i]->str);
				reply2 = redisCommand(c, "ZSCORE %s %s", "MTBF", reply->element[i]->str);
				//printf("%s\n", reply2->str);
				sum += 1 / atof(reply2->str);
				score[i] = sum;
				//score[i] = 1 / atof(reply2->str);
				//printf("%lf, %lf\n", atof(reply2->str), score[i]);
				len++;
				freeReplyObject(reply2);
			}
		}
	}
	freeReplyObject(reply);
	//printf("len:%d\n", len);

/*
	for(i=0; i<len; i++)
		printf("%lf ", score[i]);

	printf("\nlen:%d", len);
	printf("\n%lf\n", sum);
*/	
	//printf("len%d\n", len);
	int version = 0;
	srand((unsigned int)time(NULL));
	int hit = 0;
	for(i=0; i<10000; i++){
		random = (float)rand()/(float)(RAND_MAX/sum);
		//printf("%lf\n", random);
		for(j=0; j<len; j++){
			if(score[j] > random){
				//printf("[%d] %s , %d\n", i, APPID[j], j);
				strcpy(VERSIONID, APPID[j]);
				//HERE!
				strcat(VERSIONID, "VER.");
				temp = redisCommand(c, "HGET %s VERSION", APPID[j]);
				strcat(VERSIONID, temp->str);
				strcat(VERSIONID, "/mnt/nvme2n1");
				//printf("VERSION:%s\n", VERSIONID);
				//HERE_END
				//strcat(VERSIONID, "VER.0/mnt/nvme2n1");
				reply = redisCommand(c, "LRANGE %s 0 0", VERSIONID);
				if (reply->type == REDIS_REPLY_ARRAY){
					//printf("%s\n", reply->element[0]->str);
					reply2 = redisCommand(c, "GET %s", reply->element[0]->str);
					//printf("%s\n", reply2->str);
					if(strcmp(reply2->str, "/mnt/nvme2n1") == 0)
						hit++;
				}
				freeReplyObject(reply2);
				freeReplyObject(reply);
				break ;
			}
		}
	}
	
	float hitratio = (float)hit / 100;
	printf("HITRATIO: %lf\n", hitratio);
	
	
	redisFree(c);
	
	
	return 0;
}


