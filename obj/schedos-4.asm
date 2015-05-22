
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
void
start(void)
{
	int i;
	static int init = 1; 
	if (init)
  500000:	83 3d 00 00 51 00 00 	cmpl   $0x0,0x510000
  500007:	74 11                	je     50001a <start+0x1a>
    loop: goto loop; // Convince GCC that function truly does not return.
}

static inline void sys_priority(int priority)
{
  asm volatile("int %0\n"
  500009:	83 c8 ff             	or     $0xffffffff,%eax
  50000c:	cd 32                	int    $0x32
	{
	  sys_priority(-1);
	  init = 0;
  50000e:	c7 05 00 00 51 00 00 	movl   $0x0,0x510000
  500015:	00 00 00 
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500018:	cd 30                	int    $0x30
  50001a:	31 c0                	xor    %eax,%eax
	  sys_yield();
       	}
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  50001c:	8b 15 00 80 19 00    	mov    0x198000,%edx
  500022:	66 c7 02 34 0e       	movw   $0xe34,(%edx)
  500027:	83 c2 02             	add    $0x2,%edx
  50002a:	89 15 00 80 19 00    	mov    %edx,0x198000
  500030:	cd 30                	int    $0x30
	{
	  sys_priority(-1);
	  init = 0;
	  sys_yield();
       	}
	for (i = 0; i < RUNCOUNT; i++) {
  500032:	40                   	inc    %eax
  500033:	3d 40 01 00 00       	cmp    $0x140,%eax
  500038:	75 e2                	jne    50001c <start+0x1c>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  50003a:	66 31 c0             	xor    %ax,%ax
  50003d:	cd 31                	int    $0x31
  50003f:	eb fe                	jmp    50003f <start+0x3f>
