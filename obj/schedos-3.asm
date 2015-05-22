
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
void
start(void)
{
	int i;
	static int init = 1; 
	if (init)
  400000:	83 3d 00 00 41 00 00 	cmpl   $0x0,0x410000
  400007:	74 11                	je     40001a <start+0x1a>
    loop: goto loop; // Convince GCC that function truly does not return.
}

static inline void sys_priority(int priority)
{
  asm volatile("int %0\n"
  400009:	83 c8 ff             	or     $0xffffffff,%eax
  40000c:	cd 32                	int    $0x32
	{
	  sys_priority(-1);
	  init = 0;
  40000e:	c7 05 00 00 41 00 00 	movl   $0x0,0x410000
  400015:	00 00 00 
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400018:	cd 30                	int    $0x30
  40001a:	31 c0                	xor    %eax,%eax
	  sys_yield();
       	}
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  40001c:	8b 15 00 80 19 00    	mov    0x198000,%edx
  400022:	66 c7 02 33 09       	movw   $0x933,(%edx)
  400027:	83 c2 02             	add    $0x2,%edx
  40002a:	89 15 00 80 19 00    	mov    %edx,0x198000
  400030:	cd 30                	int    $0x30
	{
	  sys_priority(-1);
	  init = 0;
	  sys_yield();
       	}
	for (i = 0; i < RUNCOUNT; i++) {
  400032:	40                   	inc    %eax
  400033:	3d 40 01 00 00       	cmp    $0x140,%eax
  400038:	75 e2                	jne    40001c <start+0x1c>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  40003a:	66 31 c0             	xor    %ax,%ax
  40003d:	cd 31                	int    $0x31
  40003f:	eb fe                	jmp    40003f <start+0x3f>
