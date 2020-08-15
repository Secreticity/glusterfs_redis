#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

int main (int argc, char *argv[]) 
{
		while (1) {
				int status;
				pid_t pid = fork();
				if (-1 == pid) { perror("fork failed!"); exit(EXIT_FAILURE); }

				if (0  == pid) {
						/* Child */
						execlp("/home/dcslab/benchmark/ssd_hitratio_monitor", "/home/dcslab/benchmark/ssd_hitratio_monitor", argv[1], argv[2], argv[3], NULL);
	
						//execlp("/home/dcslab/benchmark/hanul_monitor", "/home/dcslab/benchmark/hanul_monitor", argv[1], argv[2], argv[3], NULL);
						
						//execlp("/home/dcslab/benchmark/our_monitor_LRU", "/home/dcslab/benchmark/our_monitor_LRU", argv[1], argv[2], argv[3], NULL);
						//execlp("/home/dcslab/benchmark/our_monitor", "/home/dcslab/benchmark/our_monitor", argv[1], argv[2], argv[3], NULL);
						//execlp("/home/dcslab/benchmark/adaptive_monitor", "/home/dcslab/benchmark/adaptive_monitor", argv[1], argv[2], argv[3], NULL);
						//execlp("/home/dcslab/benchmark/static_monitor", "/home/dcslab/benchmark/static_monitor", argv[1], argv[2], argv[3], NULL);
						
						perror("execlp failed!");
						exit(EXIT_FAILURE);
				}

				waitpid(pid, &status, 0);
				if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGSEGV) {
						exit(EXIT_SUCCESS);
						/* The process didn't die because of a SIGSEGV, lets keep it dead */
				}
		}
		return 0;
}
