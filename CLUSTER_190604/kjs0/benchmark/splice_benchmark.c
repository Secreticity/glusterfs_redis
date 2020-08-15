// gcc pwrite_benchmark.c -o pwrite_benchmark


#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include <sys/sendfile.h>


//1MB
//#define BUFSIZE 67108864

void append(char *s, char c)
{
	int len = strlen(s);
	s[len] = c;
	s[len+1] = '\0';
}

int main (int argc, char *argv[])
{
	static int BUFSIZE = 65536;
	char *buf = (char *) valloc (sizeof (char) * BUFSIZE + getpagesize ());
	int tofd, fromfd, fileread = 1, filewrite = 1;
	int size;
	off_t in_off = 0;
	off_t out_off = 0;

	//struct stat fstat;
	//stat (argv[2], &fstat);
	//int blksize = (int) fstat.st_blksize;	//4M blocksize
	//int align = blksize - 1;

	long pwrite_start, pwrite_end, pwrite_time = 0;
	clock_t pwrite_clock_start, pwrite_clock_time;
	struct timeval timecheck;
	int msec, clock_time = 0;

	int filedes[2];
	struct stat stbuf;
	off_t len;

	if(pipe(filedes) < 0) 
	{
		perror("pipe");
		exit(1);
	}

	if ((fromfd = open (argv[1], O_RDONLY | O_ASYNC)) == -1)
	{
		fprintf (stderr, "OPEN ERROR with FROM FILE: %s\n", strerror (errno));
		return 1;
	}
	
	if ((tofd = open (argv[2], O_CREAT | O_RDWR | O_DIRECT | O_ASYNC, 0666)) == -1)
	{
		fprintf (stderr, "OPEN ERROR with TO FILE: %s\n", strerror (errno));
		return 1;
	}
	
	if(fstat(fromfd, &stbuf) < 0)
	{
		perror("fstat: ");
		exit(1);
	}
	len = stbuf.st_size;
		
	while (len > 0)
	{
		if(BUFSIZE > len)
			BUFSIZE = len;
		//printf("offset:%ld, BUFSIZE:%ld\n", offset, BUFSIZE);

		ssize_t r = splice (fromfd, &in_off, filedes[1], NULL, BUFSIZE, SPLICE_F_MOVE | SPLICE_F_MORE);
		if (r < 0)
		{
			perror("splice_from");
			exit(1);
		}
		
		r = splice (filedes[0], NULL, tofd, &out_off, BUFSIZE, SPLICE_F_MOVE | SPLICE_F_MORE);
		if (r < 0)
		{
			perror("splice_to");
			exit(1);
		}
		//buf = (char *) malloc((int)blksize+align);
		//buf = (char *)(((uintptr_t)buf+align)&~((uintptr_t)align));
		//printf("offset:%ld, BUFSIZE:%ld\n", out_off, BUFSIZE);
		len -= BUFSIZE;
		//offset += BUFSIZE;
	}

	close (fromfd);
	close (tofd);
	close (filedes[0]);
	close (filedes[1]);
	return 0;
}
