#include <stdio.h>
#include <string.h>
#include <stdlib.h>


int main(int argc, char **argv) {
	
	char* BASENAME[4] = {"/mnt/nvme0n1", "/mnt/nvme2n1", "/mnt/nvme3n1", "/mnt/nvme4n1"};
	
	int sp[10] = { 862, 652, 443, 231, 19, 897, 783, 671, 556, 443 };
	char* goal[10] = { "1.1tb", "1.2tb", "1.3tb", "1.4tb", "1.5tb", "1.6tb", "1.7tb", "1.8tb", "1.9tb", "2.0tb" };
	int i, j;

	FILE *fp;
	char space[10];
	char TEMP[100];
	float m, b, write;
	char writeP[10];
	int intspace;

	while(1){
		strcpy(TEMP, "df -h ");
		strcat(TEMP, argv[1]);
		strcat(TEMP, " | awk '{ print $3 }' | tail -n 1");
		fp = popen(TEMP, "r");
		//fp = popen("df -h /dev/nvme2n1 | awk '{ print $3 }' | tail -n 1", "r");
		if (fgets(space, sizeof(space)-1, fp) != NULL){
			if(space[strlen(space)-2] == 'M')
				intspace = 0;
			else if (space[strlen(space)-2] == 'G')
				intspace = atoi(space);
			for(i=0; i<10; i++) {
				if(strcmp(argv[2], goal[i]) == 0) {
					if(i<5){
						if(intspace < sp[i]){
							system("sh /home/dcslab/benchmark/readwrite.sh 890");
						}
						else{
							m = (765-890) / (float)(1000-sp[i]);
							b = 765 - 1000 * m;
							write = (float)m * intspace + b;
							sprintf(writeP, "%g", write);
							strcpy(TEMP, "sh /home/dcslab/benchmark/readwrite.sh ");
							strcat(TEMP, writeP);
							system(TEMP);
						}	
					}
					else{
						if(intspace < sp[i]){
							m = (765-890) / (float)(sp[i]);
							b = 890;
							write = (float)m * intspace + b;
							sprintf(writeP, "%g", write);
							strcpy(TEMP, "sh /home/dcslab/benchmark/readwrite.sh ");
							strcat(TEMP, writeP);
							system(TEMP);
						}
						else{
							system("sh /home/dcslab/benchmark/readwrite.sh 765");
						}
					}
					break;
				}
			}
			//printf("space: %d\n", atoi(space));
		}
		close(fp);
		sleep(1);
	}
	return 0;
}
