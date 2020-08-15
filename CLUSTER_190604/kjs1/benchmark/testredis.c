#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <hiredis.h>

char* BASENAME[4] = {"/mnt/nvme0n1/", "/mnt/nvme2n1/", "/mnt/nvme3n1/", "/mnt/nvme4n1/"};
char* file[100];
int in=0;
int out=0;

int main(int argc, char **argv) {
	unsigned int i, j, k, l;
	redisContext *c;
	redisReply *reply;
	redisReply *reply2;
	redisReply *reply3;
	char APPID[100] = "";
	char VERSIONID[100] = "";

	char* array[100];
	i = 0;


	int ret = 0;
	FILE *fp;
	char path[10];
	fp = popen("iostat -xmtc 1 2 nvme2n1 | tail -n 2 | awk '{ print $9}'", "r");
	if(fgets(path, sizeof(path)-1, fp) != NULL)
			printf("path: %s, %d", path, atoi(path));
	close(fp);

	//ret = system("iostat -xmt | awk '/nvme0n1/ { print $9}'");
	//printf("ret: %d\n", ret);
	struct timeval timeout = { 1, 500000 };
	c = redisConnectWithTimeout ("127.0.0.1", 6379, timeout);
	if (c == NULL || c->err) {
		if (c) {
			printf("Connection error: %s\n", c->errstr);
			redisFree(c);
		} else {
			printf("Connection error: can't allocate redis context\n");
		}
		exit(1);
	}
	
	int s;
	reply = redisCommand(c, "HGET %s TIME", "KIM");
	if (reply->str == NULL)
		printf("YES\n");
	else
		printf("NO\n");
	freeReplyObject(reply);



	reply = redisCommand(c, "ZREVRANGE %s 0 -1", "LRU");
	if (reply->type == REDIS_REPLY_ARRAY){
		for (j=0; j<reply->elements; j++){ 
			if (strcmp(reply->element[j]->str, "") != 0){
				strcpy(APPID, reply->element[j]->str);
				strcpy(VERSIONID, APPID);
				strcat(VERSIONID, "VER.");
				reply2 = redisCommand(c, "HGET %s VERSION", APPID);
				strcat(VERSIONID, reply2->str);
				strcat(VERSIONID, "/mnt/nvme0n1");
				freeReplyObject(reply2);
				printf("%s\n%s\n ----\n", APPID, VERSIONID);
				
				reply2 = redisCommand(c, "LRANGE %s 0 -1", VERSIONID);
				if (reply2->type == REDIS_REPLY_ARRAY) {
					for (k=0; k<reply2->elements; k++) {
						if(reply2->element[k]->str != NULL) {
							for(s=0; s<3; s++){
								if(k+1+s < reply2->elements && reply2->element[k+1+s]->str != NULL){
									printf("LOOP: k:%d k+1+s:%d :::::::::::: %s\n", k, k+1+s, reply2->element[k+1+s]->str);
									file[in%100] = (char *)malloc(sizeof(char) * strlen(reply2->element[k+1+s]->str));
									strcpy(file[in%100], reply2->element[k+1+s]->str);
									printf("in:%d file:%s\n", in, file[in]);
									in++;
								}
							}
							printf("HEREAGAIN: k:%d :::::::::::: %s\n", k, reply2->element[k]->str);
							k += s;
							s=0;
							/*
							reply3 = redisCommand(c, "LPOP %s", VERSIONID);
							printf("HERE:%s\n", reply3->str);
							array[i] = (char *)malloc(sizeof(char) * strlen(reply3->str));
							strcpy(array[i], reply3->str);
							i++;
							freeReplyObject(reply3);
							*/
						}
					}
				}
				freeReplyObject(reply2);
				printf("\n\n");
			}
		}
	}
	
/*
	reply = redisCommand(c, "LRANGE %s 0 -1", "BANG");
	if(reply->type == REDIS_REPLY_STRING)
		printf("STRING\n");
	else if (reply->type == REDIS_REPLY_ARRAY)
		printf("ARRAY\n");
	else
		printf("bothnot\n");
	freeReplyObject(reply);
*/

	for(out = 0; out < 10; out++) {
		printf("out:%d, file:%s\n", out, file[out]);
	}
	/*
	char* temp;
	for (l = 0; l < i; l++){
		printf("TEST:%s\n", array[l]);
		temp = strtok(array[l], "/");
		printf("TEMP:%s\n", temp);
		temp = strtok(NULL, "/");
		printf("TEMP:%s\n", temp);
		printf("TESTAGAIN:%s\n", array[l]);
		free(array[l]);
		//array[l] = NULL;
		//printf("REMOVE:%s\n", array[l]);
	}*/
	//printf("ZREVRANGE: %s\n", reply->str);
	//
	//
	/*
	printf("\n\n");
	for (l=0; l<4; l++)
		printf("BASE:%s\n", BASENAME[l]);

	




	
	
	char* FILENAME = "aaaV0.1.0";
	printf("filename: %s\n", FILENAME);
	
	char* cmd = (char *)malloc(sizeof(char) * 100);
	strcpy(cmd, "/home/dcslab/benchmark/1M_sendfile_benchmark ");
	printf("cmd:%s\n", cmd);

	char FROM[30] = "";
	char TO[30] = "";

	strcat(cmd, BASENAME[0]);
	strcat(cmd, FILENAME);
	strcat(cmd, " /home/dcslab/benchmark/");
	strcat(cmd, FILENAME);
	printf("%s\n", cmd);
	
	int status = system(cmd);
	printf("GOOD? %d\n", status);

	strcpy(cmd, "rm ");
	strcat(cmd, BASENAME[0]);
	strcat(cmd, FILENAME);
	printf("%s\n", cmd);
	status = system(cmd);
	printf("FINISH? %d\n", status);

	freeReplyObject(reply);
	redisFree(c);
	*/



	return 0;
}
	
