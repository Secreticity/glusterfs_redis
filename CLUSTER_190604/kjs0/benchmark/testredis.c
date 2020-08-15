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

/*
	int ret = 0;
	FILE *fp;
	char path[10];
	fp = popen("iostat -xmtc 1 2 nvme2n1 | tail -n 2 | awk '{ print $9}'", "r");
	if(fgets(path, sizeof(path)-1, fp) != NULL)
			printf("path: %s, %d", path, atoi(path));
	close(fp);
*/
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
	//reply = redisCommand(c, "SET %s %d", "BREAKPOINT", 1);
	//freeReplyObject(reply);
	/*
	reply2 = redisCommand(c, "GET %s", "BREAKPOINT");
	if (reply2->integer == 0)
		printf("YES\n");
	else
		printf("NO\n");
	freeReplyObject(reply2);

	reply2 = redisCommand(c, "HGET %s VERSION", "CTX_ID:67d4b6b0-fbef-4d4b-a9f9-17bcec25d5b6-");
	int version = atoi 
	if(reply2->str == NULL)
		printf("YES\n");
	else
		printf("NO\n");
*/
/*
	FILE *urgentfp;
	FILE *tempfp;
	urgentfp = fopen("/mnt/urgent", "r");
	tempfp = fopen("/mnt/temp", "w");
	
	rewind(urgentfp);

	char buffer[100];
	char *p;

	while((fgets(buffer, 100, urgentfp)) != NULL){
		p = buffer;
		p[strlen(buffer)-1] = 0;
		printf("%s\n", buffer);
		redisReply *temp = redisCommand(c, "LRANGE %s 0 -1", buffer);
		if(temp->type == REDIS_REPLY_ARRAY){
			for (j=0; j<temp->elements; j++) 
				printf("%s\n", temp->element[j]->str);
		}
		freeReplyObject(temp);
		fputs(buffer, tempfp);
		fputs("\n", tempfp);
	}

	//delete

	remove("/mnt/urgent");
	//fclose(urgentfp);
	fclose(tempfp);
*/
	printf("HERE\n");
	reply = redisCommand(c, "LLEN %s", "STOP");
	if(reply->integer == 0){
		printf("YES\n");
		printf("%d\n", reply->integer);
		freeReplyObject(reply);
	}
	else{
		printf("NO\n");
		freeReplyObject(reply);
	}

	char* from = "from";
	char* to = (char *)malloc(sizeof(char) * strlen(from));
	strcpy(to, from);
	printf("before: %s\n", to);
	free(to);
	to='\0';
	if(to == NULL)
		printf("1111\n");
	else
		printf("%s\n", to);


/*
	reply2 = redisCommand(c, "ZREVRANGE %s %d %d WITHSCORES", "MTBF", 0, 0);
	if(reply2->type == REDIS_REPLY_ARRAY){
		if(reply2->element[0]->type == REDIS_REPLY_ERROR)
			printf("YES\n");
		else
			printf("NO\n");
	}
	else
		printf("NO\n");
	//printf("%s\n", reply2->element[1]->str);
	freeReplyObject(reply2);
*/
/*
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
							
							//reply3 = redisCommand(c, "LPOP %s", VERSIONID);
							//printf("HERE:%s\n", reply3->str);
							//array[i] = (char *)malloc(sizeof(char) * strlen(reply3->str));
							//strcpy(array[i], reply3->str);
							//i++;
							//freeReplyObject(reply3);
						}
					}
				}
				freeReplyObject(reply2);
				printf("\n\n");
			}
		}
	}
*/	
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
	
