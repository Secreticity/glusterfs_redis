// gcc pwrite_benchmark.c -o pwrite_benchmark


#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include <sys/sendfile.h>

//1MB
#define BUFSIZE 524288
//#define BUFSIZE 1048576
//#define BUFSIZE 67108864

void append(char *s, char c)
{
	int len = strlen(s);
	s[len] = c;
	s[len+1] = '\0';
}

int main (int argc, char *argv[])
{
	char *buf = (char *) valloc (sizeof (char) * BUFSIZE + getpagesize ());
	int tofd, fromfd, fileread = 1, filewrite = 1;
	int size;
	off_t offset = 0;

	struct stat fstat;
	stat (argv[2], &fstat);
	int blksize = (int) fstat.st_blksize;	//4M blocksize
	int align = blksize - 1;

	long pwrite_start, pwrite_end, pwrite_time = 0;
	clock_t pwrite_clock_start, pwrite_clock_time;
	struct timeval timecheck;
	int msec, clock_time = 0;

	char alph = 'a';

	//char *buf = (char *) malloc((int)blksize+align);
	//buf = (char *)(((uintptr_t)buf+align)&~((uintptr_t)align));
	//char *buf = (char*) malloc((int)BLOCKSIZE+ALIGN);

	//printf("%d", getpagesize());
	//printf("%ld", BUFSIZE);
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
	
	
	while (1)
	{
		/*
		if ((tofd = open (append(argv[2], alph++), O_CREAT | O_RDWR | O_DIRECT | O_ASYNC, 0666)) == -1)
		{
			fprintf (stderr, "OPEN ERROR with TO FILE: %s\n", strerror (errno));
			return 1;
		}
		*/
		fileread = sendfile (tofd, fromfd, &offset, BUFSIZE);
		if (fileread == -1)
		{
			fprintf (stderr, "Failed to read: %s\n", strerror (errno));
			free (buf);
			return 1;
		}
		if (fileread == 0)
		{
			/*printf ("total pwrite time:%lds%ldms\n", pwrite_time / 1000,
			  pwrite_time % 1000);
			  printf ("total pwrite time_clock:%ds%dms\n", clock_time / 1000,
			  clock_time % 1000);*/
			close (fromfd);
			close (tofd);
			return 1;
		}

		/*
		   gettimeofday (&timecheck, NULL);
		   pwrite_start = (long) timecheck.tv_sec * 1000 + (long) timecheck.tv_usec / 1000;

		   pwrite_clock_start = clock ();

		   filewrite = pwrite (tofd, buf, fileread, offset);

		   gettimeofday (&timecheck, NULL);
		   pwrite_end = (long) timecheck.tv_sec * 1000 + (long) timecheck.tv_usec / 1000;
		   pwrite_time += (pwrite_end - pwrite_start);

		   pwrite_clock_time = clock () - pwrite_clock_start;
		   msec = pwrite_clock_time * 1000 / CLOCKS_PER_SEC;
		   clock_time += msec;

		   if (filewrite == -1)
		   {
		   fprintf (stderr, "Failed to write: %s\n", strerror (errno));
		   free (buf);
		   return 1;
		   }

		   printf("offset:%ld\n", offset);
		   free (buf);

		   buf = (char *) valloc (sizeof (char) * BUFSIZE + getpagesize ());
		   */
		//buf = (char *) malloc((int)blksize+align);
		//buf = (char *)(((uintptr_t)buf+align)&~((uintptr_t)align));
		//printf("offset:%ld\n", offset);
		//offset += BUFSIZE;
	}

	close (fromfd);
	close (tofd);
	return 0;
}
