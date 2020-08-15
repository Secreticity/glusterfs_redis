// gcc monitor.c -o migrator -lpthread -lhiredis

#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>


int
main (int argc, char *argv[])
{
	FILE *fp;
	char perf[10];
	float fperf;
	int toggle=0;
	
	int r[20];
	int sum = 0;
	int sum2 = 0;
	int i;

	int lower = 25;
	int upper = 75;

	srand(time(NULL));

	for(i=0; i<20; i++){
		int num = (rand() % (upper-lower+1)) + lower;
		printf("%d \n", num);
	}

/*
	for(i=0; i<20; i++){
		r[i] = rand()%100;
		sum += r[i];
		printf("[%d] random:%d sum:%d\n", i, r[i], sum);
	}
	printf("%d--------------------------------\n", sum);
	for(i=0; i<20; i++) {
		r[i] = r[i]*1760/sum;
		sum2 += r[i];
		printf("[%d] reult:%d\n", i, r[i]);
	}
	printf("%d--------------------------------\n", sum2);
*/

/*

	while (1) {
		fp = popen("iostat -d nvme2n1 1 2 | tail -n 2 | awk '{print $4}'", "r");
		if(fgets(perf, sizeof(perf)-1, fp) != NULL) {
			fperf = atof(perf);
			printf("%lf\n", fperf);
			if(fperf == 0)
				toggle++;
			else
				toggle=0;
			if(toggle >= 3)
				printf("Breakpoint!!--------\n");
		}
		pclose(fp);
	}
*/
	return 0;
}


