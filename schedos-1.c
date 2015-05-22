#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

void
start(void)
{
    int i;
    static int init = 1;
    
    int print_this = PRINTCHAR;
    
    //#4A FOR SCHEDULER 2 ALGORITHM
    if (init)
    {
        //SYSTEM CALL FOR #4A
        sys_priority(-1);
        init = 0;
        sys_yield();
        //EXERCISE 4B, SET ALL ITERATIONS TO 0
        proc->iteration = 0;
    }
    
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		//*cursorpos++ = PRINTCHAR;
        //#6 SYSTEM CALL
        sys_print(print_this);
        proc->iteration++;
		sys_yield();
	}
	// EXIT
	sys_exit(0);
}
