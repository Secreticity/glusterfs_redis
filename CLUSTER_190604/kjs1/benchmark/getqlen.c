#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
	FILE *fp;
	char qlen[10];
	while(1) {
		fp = popen("iostat -xmtc 1 2 nvme2n1 | tail -n 2 | awk '{ print $9}'", "r");
		if(fgets(qlen, sizeof(qlen)-1, fp) != NULL)
				printf("qlen: %d\n", atoi(qlen));
		close(fp);
	}
	return 0;
}
