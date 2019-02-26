/*
ZYNQ
Test du DDS
*/

#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>

int main(int argc, char *argv[]) {
  int fd;
  void *config, *dat;
  char *name = "/dev/mem";
  long long lPrg;

  if ((fd = open(name, O_RDWR)) < 0) {
    perror("open");
    return EXIT_FAILURE;
  }

  config = mmap(NULL, sysconf(_SC_PAGESIZE), PROT_READ | PROT_WRITE, MAP_SHARED,       fd, 0x40000000);
  dat = mmap(NULL, sysconf(_SC_PAGESIZE), PROT_READ | PROT_WRITE, MAP_SHARED,           fd, 0x41200000);
  
  if( argc == 2 ) {
	    lPrg=0x100000000*atoll(argv[1]);   // 32 bts
	    lPrg/=500000000;  // div 500MHz
       *((uint32_t *)(config )) = lPrg;
       printf("500Mhz Programme : %lld \n",lPrg);
   }
   else printf("pas de parram\n");

  return EXIT_SUCCESS;

}
