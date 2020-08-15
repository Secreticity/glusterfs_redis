// gcc pread_benchmark.c -o pread_benchmark

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

#define BUFSIZE 131072

int
main (int argc, char *argv[])
{
  char *buf = (char *) valloc (sizeof (char) * BUFSIZE + getpagesize ());
  int fd, fileread = 1;
  int size;
  off_t offset = 0;

  struct stat fstat;
  stat (argv[2], &fstat);
  int blksize = (int) fstat.st_blksize;	//4M blocksize
  int align = blksize - 1;

  long pread_start, pread_end, pread_time = 0;
  clock_t pread_clock_start, pread_clock_time;
  struct timeval timecheck;
  int msec, clock_time = 0;


  //char *buf = (char *) malloc((int)blksize+align);
  //buf = (char *)(((uintptr_t)buf+align)&~((uintptr_t)align));
  //char *buf = (char*) malloc((int)BLOCKSIZE+ALIGN);

  //printf("%d", getpagesize());
  //printf("%ld", BUFSIZE);
  if ((fd = open (argv[1], O_RDONLY)) == -1)
    {
      fprintf (stderr, "OPEN ERROR with FILE: %s\n", strerror (errno));
      return 1;
    }

  while (1)
    {
      gettimeofday (&timecheck, NULL);
      pread_start =
	(long) timecheck.tv_sec * 1000 + (long) timecheck.tv_usec / 1000;
      pread_clock_start = clock ();
      fileread = pread (fd, buf, BUFSIZE, offset);
      gettimeofday (&timecheck, NULL);
      pread_end =
	(long) timecheck.tv_sec * 1000 + (long) timecheck.tv_usec / 1000;
      pread_time += (pread_end - pread_start);
      msec = pread_clock_time * 1000 / CLOCKS_PER_SEC;
      clock_time += msec;

      if (fileread == -1)
	{
	  fprintf (stderr, "Failed to read: %s\n", strerror (errno));
	  free (buf);
	  return 1;
	}
      if (fileread == 0)
	{
	  printf ("total pread time:%lds%ldms\n", pread_time / 1000,
		  pread_time % 1000);
	  printf ("total pread time_clock:%ds%dms\n", clock_time / 1000,
		  clock_time % 1000);
	  close (fd);
	  return 1;
	}

      free (buf);

      buf = (char *) valloc (sizeof (char) * BUFSIZE + getpagesize ());
      offset += BUFSIZE;
    }

  close (fd);
  return 0;
}
