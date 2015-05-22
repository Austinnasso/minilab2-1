
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 fd 01 00 00       	call   100216 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 00 01 00 00       	call   100172 <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid; 
  10009c:	a1 38 bd 10 00       	mov    0x10bd38,%eax
 *
 *****************************************************************************/

void
schedule(void)
{
  1000a1:	57                   	push   %edi
  1000a2:	56                   	push   %esi
  1000a3:	53                   	push   %ebx
	pid_t pid = current->p_pid; 
  1000a4:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a6:	a1 3c bd 10 00       	mov    0x10bd3c,%eax
  1000ab:	85 c0                	test   %eax,%eax
  1000ad:	75 19                	jne    1000c8 <schedule+0x2c>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000af:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b4:	8d 42 01             	lea    0x1(%edx),%eax
  1000b7:	99                   	cltd   
  1000b8:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000ba:	6b c2 54             	imul   $0x54,%edx,%eax
  1000bd:	83 b8 74 b3 10 00 01 	cmpl   $0x1,0x10b374(%eax)
  1000c4:	75 ee                	jne    1000b4 <schedule+0x18>
  1000c6:	eb 1b                	jmp    1000e3 <schedule+0x47>
				run(&proc_array[pid]);
		}

	else if (scheduling_algorithm == 1)
  1000c8:	83 f8 01             	cmp    $0x1,%eax
  1000cb:	75 29                	jne    1000f6 <schedule+0x5a>
  1000cd:	ba 01 00 00 00       	mov    $0x1,%edx
	    while (1) 
	      { 
		  if (proc_array[pid].p_state == P_RUNNABLE)
		    run(&proc_array[pid]);

		  pid = (pid + 1) % NPROCS;
  1000d2:	b9 05 00 00 00       	mov    $0x5,%ecx
	else if (scheduling_algorithm == 1)
	  {
	    pid = 1; 
	    while (1) 
	      { 
		  if (proc_array[pid].p_state == P_RUNNABLE)
  1000d7:	6b c2 54             	imul   $0x54,%edx,%eax
  1000da:	83 b8 74 b3 10 00 01 	cmpl   $0x1,0x10b374(%eax)
  1000e1:	75 0b                	jne    1000ee <schedule+0x52>
		    run(&proc_array[pid]);
  1000e3:	83 ec 0c             	sub    $0xc,%esp
  1000e6:	05 2c b3 10 00       	add    $0x10b32c,%eax
  1000eb:	50                   	push   %eax
  1000ec:	eb 5e                	jmp    10014c <schedule+0xb0>

		  pid = (pid + 1) % NPROCS;
  1000ee:	8d 42 01             	lea    0x1(%edx),%eax
  1000f1:	99                   	cltd   
  1000f2:	f7 f9                	idiv   %ecx
	      } 
  1000f4:	eb e1                	jmp    1000d7 <schedule+0x3b>
	  }

	else if (scheduling_algorithm == 2)
  1000f6:	83 f8 02             	cmp    $0x2,%eax
  1000f9:	75 56                	jne    100151 <schedule+0xb5>
  1000fb:	ba 01 00 00 00       	mov    $0x1,%edx
  100100:	b9 01 00 00 00       	mov    $0x1,%ecx
  100105:	31 db                	xor    %ebx,%ebx
		  maxPid = pid;
		  break;
		  }*/

		i++;
		pid = (pid + 1) % NPROCS;
  100107:	be 05 00 00 00       	mov    $0x5,%esi
	       pid = (oldPid + 1) % NPROCS;*/ 

	    while (i<NPROCS)
	    {
	      //SKIP IF NOT RUNNABLE
	      if (proc_array[pid].p_state == P_RUNNABLE)
  10010c:	6b c2 54             	imul   $0x54,%edx,%eax
  10010f:	83 b8 74 b3 10 00 01 	cmpl   $0x1,0x10b374(%eax)
  100116:	75 13                	jne    10012b <schedule+0x8f>
	        {
		    if (proc_array[pid].p_priority < proc_array[maxPid].p_priority)
  100118:	6b f9 54             	imul   $0x54,%ecx,%edi
  10011b:	8b 80 7c b3 10 00    	mov    0x10b37c(%eax),%eax
  100121:	3b 87 7c b3 10 00    	cmp    0x10b37c(%edi),%eax
  100127:	7d 02                	jge    10012b <schedule+0x8f>
  100129:	89 d1                	mov    %edx,%ecx
		{
		  maxPid = pid;
		  break;
		  }*/

		i++;
  10012b:	43                   	inc    %ebx
	    //INITIALIZE PROCESSES FIRST
	    int x = 0;
	    /* if (oldPid != -1)
	       pid = (oldPid + 1) % NPROCS;*/ 

	    while (i<NPROCS)
  10012c:	83 fb 05             	cmp    $0x5,%ebx
  10012f:	74 08                	je     100139 <schedule+0x9d>
		  maxPid = pid;
		  break;
		  }*/

		i++;
		pid = (pid + 1) % NPROCS;
  100131:	8d 42 01             	lea    0x1(%edx),%eax
  100134:	99                   	cltd   
  100135:	f7 fe                	idiv   %esi
  100137:	eb d3                	jmp    10010c <schedule+0x70>
	    }

	    oldPid = maxPid; 
  100139:	89 0d 00 10 10 00    	mov    %ecx,0x101000
	    run(&proc_array[maxPid]);
  10013f:	6b c9 54             	imul   $0x54,%ecx,%ecx
  100142:	83 ec 0c             	sub    $0xc,%esp
  100145:	81 c1 2c b3 10 00    	add    $0x10b32c,%ecx
  10014b:	51                   	push   %ecx
  10014c:	e8 d8 03 00 00       	call   100529 <run>
	  }

	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100151:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100157:	50                   	push   %eax
  100158:	68 e8 0a 10 00       	push   $0x100ae8
  10015d:	68 00 01 00 00       	push   $0x100
  100162:	52                   	push   %edx
  100163:	e8 66 09 00 00       	call   100ace <console_printf>
  100168:	83 c4 10             	add    $0x10,%esp
  10016b:	a3 00 80 19 00       	mov    %eax,0x198000
  100170:	eb fe                	jmp    100170 <schedule+0xd4>

00100172 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100172:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100173:	a1 38 bd 10 00       	mov    0x10bd38,%eax
  100178:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10017d:	56                   	push   %esi
  10017e:	53                   	push   %ebx
  10017f:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100183:	8d 78 04             	lea    0x4(%eax),%edi
  100186:	89 de                	mov    %ebx,%esi
  100188:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10018a:	8b 53 28             	mov    0x28(%ebx),%edx
  10018d:	83 fa 31             	cmp    $0x31,%edx
  100190:	74 1f                	je     1001b1 <interrupt+0x3f>
  100192:	77 0c                	ja     1001a0 <interrupt+0x2e>
  100194:	83 fa 20             	cmp    $0x20,%edx
  100197:	74 76                	je     10020f <interrupt+0x9d>
  100199:	83 fa 30             	cmp    $0x30,%edx
  10019c:	74 0e                	je     1001ac <interrupt+0x3a>
  10019e:	eb 74                	jmp    100214 <interrupt+0xa2>
  1001a0:	83 fa 32             	cmp    $0x32,%edx
  1001a3:	74 23                	je     1001c8 <interrupt+0x56>
  1001a5:	83 fa 33             	cmp    $0x33,%edx
  1001a8:	74 5c                	je     100206 <interrupt+0x94>
  1001aa:	eb 68                	jmp    100214 <interrupt+0xa2>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001ac:	e8 eb fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001b1:	a1 38 bd 10 00       	mov    0x10bd38,%eax
		current->p_exit_status = reg->reg_eax;
  1001b6:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001b9:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1001c0:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1001c3:	e8 d4 fe ff ff       	call   10009c <schedule>

	case INT_SYS_PRIORITY:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
	        current->p_priority = reg->reg_eax;
  1001c8:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001cb:	a1 38 bd 10 00       	mov    0x10bd38,%eax
  1001d0:	89 50 50             	mov    %edx,0x50(%eax)
		
		//TEST
		if (reg->reg_eax == -1)
  1001d3:	42                   	inc    %edx
  1001d4:	75 30                	jne    100206 <interrupt+0x94>
		  {
		    if (current->p_pid == 1)
  1001d6:	83 38 01             	cmpl   $0x1,(%eax)
  1001d9:	75 07                	jne    1001e2 <interrupt+0x70>
		      current->p_priority = 4;
  1001db:	c7 40 50 04 00 00 00 	movl   $0x4,0x50(%eax)

		    if (current->p_pid == 2)
  1001e2:	83 38 02             	cmpl   $0x2,(%eax)
  1001e5:	75 07                	jne    1001ee <interrupt+0x7c>
		      current->p_priority = 2;
  1001e7:	c7 40 50 02 00 00 00 	movl   $0x2,0x50(%eax)

		    if (current->p_pid == 3)
  1001ee:	83 38 03             	cmpl   $0x3,(%eax)
  1001f1:	75 07                	jne    1001fa <interrupt+0x88>
		      current->p_priority = 3;
  1001f3:	c7 40 50 03 00 00 00 	movl   $0x3,0x50(%eax)

		    if (current->p_pid == 4)
  1001fa:	83 38 04             	cmpl   $0x4,(%eax)
  1001fd:	75 07                	jne    100206 <interrupt+0x94>
		      current->p_priority = 1;
  1001ff:	c7 40 50 01 00 00 00 	movl   $0x1,0x50(%eax)
		  }
		run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100206:	83 ec 0c             	sub    $0xc,%esp
  100209:	50                   	push   %eax
  10020a:	e8 1a 03 00 00       	call   100529 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10020f:	e8 88 fe ff ff       	call   10009c <schedule>
  100214:	eb fe                	jmp    100214 <interrupt+0xa2>

00100216 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100216:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100217:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  10021c:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10021d:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10021f:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100220:	bb 80 b3 10 00       	mov    $0x10b380,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100225:	e8 de 00 00 00       	call   100308 <segments_init>
	interrupt_controller_init(0);
  10022a:	83 ec 0c             	sub    $0xc,%esp
  10022d:	6a 00                	push   $0x0
  10022f:	e8 cf 01 00 00       	call   100403 <interrupt_controller_init>
	console_clear();
  100234:	e8 53 02 00 00       	call   10048c <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100239:	83 c4 0c             	add    $0xc,%esp
  10023c:	68 a4 01 00 00       	push   $0x1a4
  100241:	6a 00                	push   $0x0
  100243:	68 2c b3 10 00       	push   $0x10b32c
  100248:	e8 1f 04 00 00       	call   10066c <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10024d:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100250:	c7 05 2c b3 10 00 00 	movl   $0x0,0x10b32c
  100257:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10025a:	c7 05 74 b3 10 00 00 	movl   $0x0,0x10b374
  100261:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100264:	c7 05 80 b3 10 00 01 	movl   $0x1,0x10b380
  10026b:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10026e:	c7 05 c8 b3 10 00 00 	movl   $0x0,0x10b3c8
  100275:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100278:	c7 05 d4 b3 10 00 02 	movl   $0x2,0x10b3d4
  10027f:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100282:	c7 05 1c b4 10 00 00 	movl   $0x0,0x10b41c
  100289:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10028c:	c7 05 28 b4 10 00 03 	movl   $0x3,0x10b428
  100293:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100296:	c7 05 70 b4 10 00 00 	movl   $0x0,0x10b470
  10029d:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002a0:	c7 05 7c b4 10 00 04 	movl   $0x4,0x10b47c
  1002a7:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002aa:	c7 05 c4 b4 10 00 00 	movl   $0x0,0x10b4c4
  1002b1:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1002b4:	83 ec 0c             	sub    $0xc,%esp
  1002b7:	53                   	push   %ebx
  1002b8:	e8 83 02 00 00       	call   100540 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002bd:	58                   	pop    %eax
  1002be:	5a                   	pop    %edx
  1002bf:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002c2:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002c5:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002cb:	50                   	push   %eax
  1002cc:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002cd:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002ce:	e8 a9 02 00 00       	call   10057c <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002d3:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002d6:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  1002dd:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002e0:	83 fe 04             	cmp    $0x4,%esi
  1002e3:	75 cf                	jne    1002b4 <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 2;

	// Switch to the first process.
	run(&proc_array[1]);
  1002e5:	83 ec 0c             	sub    $0xc,%esp
  1002e8:	68 80 b3 10 00       	push   $0x10b380
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1002ed:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1002f4:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 2;
  1002f7:	c7 05 3c bd 10 00 02 	movl   $0x2,0x10bd3c
  1002fe:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100301:	e8 23 02 00 00       	call   100529 <run>
  100306:	90                   	nop
  100307:	90                   	nop

00100308 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100308:	b8 d0 b4 10 00       	mov    $0x10b4d0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10030d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100312:	89 c2                	mov    %eax,%edx
  100314:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100317:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100318:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10031d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100320:	66 a3 3e 10 10 00    	mov    %ax,0x10103e
  100326:	c1 e8 18             	shr    $0x18,%eax
  100329:	88 15 40 10 10 00    	mov    %dl,0x101040
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10032f:	ba 38 b5 10 00       	mov    $0x10b538,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100334:	a2 43 10 10 00       	mov    %al,0x101043
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100339:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10033b:	66 c7 05 3c 10 10 00 	movw   $0x68,0x10103c
  100342:	68 00 
  100344:	c6 05 42 10 10 00 40 	movb   $0x40,0x101042
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10034b:	c6 05 41 10 10 00 89 	movb   $0x89,0x101041

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100352:	c7 05 d4 b4 10 00 00 	movl   $0x180000,0x10b4d4
  100359:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10035c:	66 c7 05 d8 b4 10 00 	movw   $0x10,0x10b4d8
  100363:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100365:	66 89 0c c5 38 b5 10 	mov    %cx,0x10b538(,%eax,8)
  10036c:	00 
  10036d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100374:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100379:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10037e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100383:	40                   	inc    %eax
  100384:	3d 00 01 00 00       	cmp    $0x100,%eax
  100389:	75 da                	jne    100365 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10038b:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100390:	ba 38 b5 10 00       	mov    $0x10b538,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100395:	66 a3 38 b6 10 00    	mov    %ax,0x10b638
  10039b:	c1 e8 10             	shr    $0x10,%eax
  10039e:	66 a3 3e b6 10 00    	mov    %ax,0x10b63e
  1003a4:	b8 30 00 00 00       	mov    $0x30,%eax
  1003a9:	66 c7 05 3a b6 10 00 	movw   $0x8,0x10b63a
  1003b0:	08 00 
  1003b2:	c6 05 3c b6 10 00 00 	movb   $0x0,0x10b63c
  1003b9:	c6 05 3d b6 10 00 8e 	movb   $0x8e,0x10b63d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c0:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003c7:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003ce:	66 89 0c c5 38 b5 10 	mov    %cx,0x10b538(,%eax,8)
  1003d5:	00 
  1003d6:	c1 e9 10             	shr    $0x10,%ecx
  1003d9:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003de:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003e3:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1003e8:	40                   	inc    %eax
  1003e9:	83 f8 3a             	cmp    $0x3a,%eax
  1003ec:	75 d2                	jne    1003c0 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003ee:	b0 28                	mov    $0x28,%al
  1003f0:	0f 01 15 04 10 10 00 	lgdtl  0x101004
  1003f7:	0f 00 d8             	ltr    %ax
  1003fa:	0f 01 1d 0c 10 10 00 	lidtl  0x10100c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100401:	5b                   	pop    %ebx
  100402:	c3                   	ret    

00100403 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100403:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100404:	b0 ff                	mov    $0xff,%al
  100406:	57                   	push   %edi
  100407:	56                   	push   %esi
  100408:	53                   	push   %ebx
  100409:	bb 21 00 00 00       	mov    $0x21,%ebx
  10040e:	89 da                	mov    %ebx,%edx
  100410:	ee                   	out    %al,(%dx)
  100411:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100416:	89 ca                	mov    %ecx,%edx
  100418:	ee                   	out    %al,(%dx)
  100419:	be 11 00 00 00       	mov    $0x11,%esi
  10041e:	bf 20 00 00 00       	mov    $0x20,%edi
  100423:	89 f0                	mov    %esi,%eax
  100425:	89 fa                	mov    %edi,%edx
  100427:	ee                   	out    %al,(%dx)
  100428:	b0 20                	mov    $0x20,%al
  10042a:	89 da                	mov    %ebx,%edx
  10042c:	ee                   	out    %al,(%dx)
  10042d:	b0 04                	mov    $0x4,%al
  10042f:	ee                   	out    %al,(%dx)
  100430:	b0 03                	mov    $0x3,%al
  100432:	ee                   	out    %al,(%dx)
  100433:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100438:	89 f0                	mov    %esi,%eax
  10043a:	89 ea                	mov    %ebp,%edx
  10043c:	ee                   	out    %al,(%dx)
  10043d:	b0 28                	mov    $0x28,%al
  10043f:	89 ca                	mov    %ecx,%edx
  100441:	ee                   	out    %al,(%dx)
  100442:	b0 02                	mov    $0x2,%al
  100444:	ee                   	out    %al,(%dx)
  100445:	b0 01                	mov    $0x1,%al
  100447:	ee                   	out    %al,(%dx)
  100448:	b0 68                	mov    $0x68,%al
  10044a:	89 fa                	mov    %edi,%edx
  10044c:	ee                   	out    %al,(%dx)
  10044d:	be 0a 00 00 00       	mov    $0xa,%esi
  100452:	89 f0                	mov    %esi,%eax
  100454:	ee                   	out    %al,(%dx)
  100455:	b0 68                	mov    $0x68,%al
  100457:	89 ea                	mov    %ebp,%edx
  100459:	ee                   	out    %al,(%dx)
  10045a:	89 f0                	mov    %esi,%eax
  10045c:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  10045d:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100462:	89 da                	mov    %ebx,%edx
  100464:	19 c0                	sbb    %eax,%eax
  100466:	f7 d0                	not    %eax
  100468:	05 ff 00 00 00       	add    $0xff,%eax
  10046d:	ee                   	out    %al,(%dx)
  10046e:	b0 ff                	mov    $0xff,%al
  100470:	89 ca                	mov    %ecx,%edx
  100472:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100473:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100478:	74 0d                	je     100487 <interrupt_controller_init+0x84>
  10047a:	b2 43                	mov    $0x43,%dl
  10047c:	b0 34                	mov    $0x34,%al
  10047e:	ee                   	out    %al,(%dx)
  10047f:	b0 9c                	mov    $0x9c,%al
  100481:	b2 40                	mov    $0x40,%dl
  100483:	ee                   	out    %al,(%dx)
  100484:	b0 2e                	mov    $0x2e,%al
  100486:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100487:	5b                   	pop    %ebx
  100488:	5e                   	pop    %esi
  100489:	5f                   	pop    %edi
  10048a:	5d                   	pop    %ebp
  10048b:	c3                   	ret    

0010048c <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10048c:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10048d:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10048f:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100490:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100497:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10049a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004a0:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004a6:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004a9:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004ae:	75 ea                	jne    10049a <console_clear+0xe>
  1004b0:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004b5:	b0 0e                	mov    $0xe,%al
  1004b7:	89 f2                	mov    %esi,%edx
  1004b9:	ee                   	out    %al,(%dx)
  1004ba:	31 c9                	xor    %ecx,%ecx
  1004bc:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004c1:	88 c8                	mov    %cl,%al
  1004c3:	89 da                	mov    %ebx,%edx
  1004c5:	ee                   	out    %al,(%dx)
  1004c6:	b0 0f                	mov    $0xf,%al
  1004c8:	89 f2                	mov    %esi,%edx
  1004ca:	ee                   	out    %al,(%dx)
  1004cb:	88 c8                	mov    %cl,%al
  1004cd:	89 da                	mov    %ebx,%edx
  1004cf:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004d0:	5b                   	pop    %ebx
  1004d1:	5e                   	pop    %esi
  1004d2:	c3                   	ret    

001004d3 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004d3:	ba 64 00 00 00       	mov    $0x64,%edx
  1004d8:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004d9:	a8 01                	test   $0x1,%al
  1004db:	74 45                	je     100522 <console_read_digit+0x4f>
  1004dd:	b2 60                	mov    $0x60,%dl
  1004df:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004e0:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004e3:	80 fa 08             	cmp    $0x8,%dl
  1004e6:	77 05                	ja     1004ed <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004e8:	0f b6 c0             	movzbl %al,%eax
  1004eb:	48                   	dec    %eax
  1004ec:	c3                   	ret    
	else if (data == 0x0B)
  1004ed:	3c 0b                	cmp    $0xb,%al
  1004ef:	74 35                	je     100526 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004f1:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004f4:	80 fa 02             	cmp    $0x2,%dl
  1004f7:	77 07                	ja     100500 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004f9:	0f b6 c0             	movzbl %al,%eax
  1004fc:	83 e8 40             	sub    $0x40,%eax
  1004ff:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100500:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100503:	80 fa 02             	cmp    $0x2,%dl
  100506:	77 07                	ja     10050f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100508:	0f b6 c0             	movzbl %al,%eax
  10050b:	83 e8 47             	sub    $0x47,%eax
  10050e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10050f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100512:	80 fa 02             	cmp    $0x2,%dl
  100515:	77 07                	ja     10051e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100517:	0f b6 c0             	movzbl %al,%eax
  10051a:	83 e8 4e             	sub    $0x4e,%eax
  10051d:	c3                   	ret    
	else if (data == 0x53)
  10051e:	3c 53                	cmp    $0x53,%al
  100520:	74 04                	je     100526 <console_read_digit+0x53>
  100522:	83 c8 ff             	or     $0xffffffff,%eax
  100525:	c3                   	ret    
  100526:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100528:	c3                   	ret    

00100529 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100529:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  10052d:	a3 38 bd 10 00       	mov    %eax,0x10bd38

	asm volatile("movl %0,%%esp\n\t"
  100532:	83 c0 04             	add    $0x4,%eax
  100535:	89 c4                	mov    %eax,%esp
  100537:	61                   	popa   
  100538:	07                   	pop    %es
  100539:	1f                   	pop    %ds
  10053a:	83 c4 08             	add    $0x8,%esp
  10053d:	cf                   	iret   
  10053e:	eb fe                	jmp    10053e <run+0x15>

00100540 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100540:	53                   	push   %ebx
  100541:	83 ec 0c             	sub    $0xc,%esp
  100544:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100548:	6a 44                	push   $0x44
  10054a:	6a 00                	push   $0x0
  10054c:	8d 43 04             	lea    0x4(%ebx),%eax
  10054f:	50                   	push   %eax
  100550:	e8 17 01 00 00       	call   10066c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100555:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10055b:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100561:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100567:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  10056d:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100574:	83 c4 18             	add    $0x18,%esp
  100577:	5b                   	pop    %ebx
  100578:	c3                   	ret    
  100579:	90                   	nop
  10057a:	90                   	nop
  10057b:	90                   	nop

0010057c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10057c:	55                   	push   %ebp
  10057d:	57                   	push   %edi
  10057e:	56                   	push   %esi
  10057f:	53                   	push   %ebx
  100580:	83 ec 1c             	sub    $0x1c,%esp
  100583:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100587:	83 f8 03             	cmp    $0x3,%eax
  10058a:	7f 04                	jg     100590 <program_loader+0x14>
  10058c:	85 c0                	test   %eax,%eax
  10058e:	79 02                	jns    100592 <program_loader+0x16>
  100590:	eb fe                	jmp    100590 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100592:	8b 34 c5 44 10 10 00 	mov    0x101044(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100599:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10059f:	74 02                	je     1005a3 <program_loader+0x27>
  1005a1:	eb fe                	jmp    1005a1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005a3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005a6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005aa:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005ac:	c1 e5 05             	shl    $0x5,%ebp
  1005af:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005b2:	eb 3f                	jmp    1005f3 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005b4:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005b7:	75 37                	jne    1005f0 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005b9:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005bc:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005bf:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005c2:	01 c7                	add    %eax,%edi
	memsz += va;
  1005c4:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005cb:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005cf:	52                   	push   %edx
  1005d0:	89 fa                	mov    %edi,%edx
  1005d2:	29 c2                	sub    %eax,%edx
  1005d4:	52                   	push   %edx
  1005d5:	8b 53 04             	mov    0x4(%ebx),%edx
  1005d8:	01 f2                	add    %esi,%edx
  1005da:	52                   	push   %edx
  1005db:	50                   	push   %eax
  1005dc:	e8 27 00 00 00       	call   100608 <memcpy>
  1005e1:	83 c4 10             	add    $0x10,%esp
  1005e4:	eb 04                	jmp    1005ea <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005e6:	c6 07 00             	movb   $0x0,(%edi)
  1005e9:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005ea:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005ee:	72 f6                	jb     1005e6 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005f0:	83 c3 20             	add    $0x20,%ebx
  1005f3:	39 eb                	cmp    %ebp,%ebx
  1005f5:	72 bd                	jb     1005b4 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005f7:	8b 56 18             	mov    0x18(%esi),%edx
  1005fa:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005fe:	89 10                	mov    %edx,(%eax)
}
  100600:	83 c4 1c             	add    $0x1c,%esp
  100603:	5b                   	pop    %ebx
  100604:	5e                   	pop    %esi
  100605:	5f                   	pop    %edi
  100606:	5d                   	pop    %ebp
  100607:	c3                   	ret    

00100608 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100608:	56                   	push   %esi
  100609:	31 d2                	xor    %edx,%edx
  10060b:	53                   	push   %ebx
  10060c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100610:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100614:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100618:	eb 08                	jmp    100622 <memcpy+0x1a>
		*d++ = *s++;
  10061a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10061d:	4e                   	dec    %esi
  10061e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100621:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100622:	85 f6                	test   %esi,%esi
  100624:	75 f4                	jne    10061a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100626:	5b                   	pop    %ebx
  100627:	5e                   	pop    %esi
  100628:	c3                   	ret    

00100629 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100629:	57                   	push   %edi
  10062a:	56                   	push   %esi
  10062b:	53                   	push   %ebx
  10062c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100630:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100634:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100638:	39 c7                	cmp    %eax,%edi
  10063a:	73 26                	jae    100662 <memmove+0x39>
  10063c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10063f:	39 c6                	cmp    %eax,%esi
  100641:	76 1f                	jbe    100662 <memmove+0x39>
		s += n, d += n;
  100643:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100646:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100648:	eb 07                	jmp    100651 <memmove+0x28>
			*--d = *--s;
  10064a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10064d:	4a                   	dec    %edx
  10064e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100651:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100652:	85 d2                	test   %edx,%edx
  100654:	75 f4                	jne    10064a <memmove+0x21>
  100656:	eb 10                	jmp    100668 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100658:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10065b:	4a                   	dec    %edx
  10065c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10065f:	41                   	inc    %ecx
  100660:	eb 02                	jmp    100664 <memmove+0x3b>
  100662:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100664:	85 d2                	test   %edx,%edx
  100666:	75 f0                	jne    100658 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100668:	5b                   	pop    %ebx
  100669:	5e                   	pop    %esi
  10066a:	5f                   	pop    %edi
  10066b:	c3                   	ret    

0010066c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10066c:	53                   	push   %ebx
  10066d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100671:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100675:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100679:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10067b:	eb 04                	jmp    100681 <memset+0x15>
		*p++ = c;
  10067d:	88 1a                	mov    %bl,(%edx)
  10067f:	49                   	dec    %ecx
  100680:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100681:	85 c9                	test   %ecx,%ecx
  100683:	75 f8                	jne    10067d <memset+0x11>
		*p++ = c;
	return v;
}
  100685:	5b                   	pop    %ebx
  100686:	c3                   	ret    

00100687 <strlen>:

size_t
strlen(const char *s)
{
  100687:	8b 54 24 04          	mov    0x4(%esp),%edx
  10068b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10068d:	eb 01                	jmp    100690 <strlen+0x9>
		++n;
  10068f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100690:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100694:	75 f9                	jne    10068f <strlen+0x8>
		++n;
	return n;
}
  100696:	c3                   	ret    

00100697 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100697:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10069b:	31 c0                	xor    %eax,%eax
  10069d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006a1:	eb 01                	jmp    1006a4 <strnlen+0xd>
		++n;
  1006a3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006a4:	39 d0                	cmp    %edx,%eax
  1006a6:	74 06                	je     1006ae <strnlen+0x17>
  1006a8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006ac:	75 f5                	jne    1006a3 <strnlen+0xc>
		++n;
	return n;
}
  1006ae:	c3                   	ret    

001006af <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006af:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006b0:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006b5:	53                   	push   %ebx
  1006b6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006b8:	76 05                	jbe    1006bf <console_putc+0x10>
  1006ba:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006bf:	80 fa 0a             	cmp    $0xa,%dl
  1006c2:	75 2c                	jne    1006f0 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006c4:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006ca:	be 50 00 00 00       	mov    $0x50,%esi
  1006cf:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006d1:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006d4:	99                   	cltd   
  1006d5:	f7 fe                	idiv   %esi
  1006d7:	89 de                	mov    %ebx,%esi
  1006d9:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006db:	eb 07                	jmp    1006e4 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006dd:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006e0:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006e1:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006e4:	83 f8 50             	cmp    $0x50,%eax
  1006e7:	75 f4                	jne    1006dd <console_putc+0x2e>
  1006e9:	29 d0                	sub    %edx,%eax
  1006eb:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006ee:	eb 0b                	jmp    1006fb <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006f0:	0f b6 d2             	movzbl %dl,%edx
  1006f3:	09 ca                	or     %ecx,%edx
  1006f5:	66 89 13             	mov    %dx,(%ebx)
  1006f8:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006fb:	5b                   	pop    %ebx
  1006fc:	5e                   	pop    %esi
  1006fd:	c3                   	ret    

001006fe <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006fe:	56                   	push   %esi
  1006ff:	53                   	push   %ebx
  100700:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100704:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100707:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10070b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100710:	75 04                	jne    100716 <fill_numbuf+0x18>
  100712:	85 d2                	test   %edx,%edx
  100714:	74 10                	je     100726 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100716:	89 d0                	mov    %edx,%eax
  100718:	31 d2                	xor    %edx,%edx
  10071a:	f7 f1                	div    %ecx
  10071c:	4b                   	dec    %ebx
  10071d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100720:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100722:	89 c2                	mov    %eax,%edx
  100724:	eb ec                	jmp    100712 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100726:	89 d8                	mov    %ebx,%eax
  100728:	5b                   	pop    %ebx
  100729:	5e                   	pop    %esi
  10072a:	c3                   	ret    

0010072b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10072b:	55                   	push   %ebp
  10072c:	57                   	push   %edi
  10072d:	56                   	push   %esi
  10072e:	53                   	push   %ebx
  10072f:	83 ec 38             	sub    $0x38,%esp
  100732:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100736:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10073a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10073e:	e9 60 03 00 00       	jmp    100aa3 <console_vprintf+0x378>
		if (*format != '%') {
  100743:	80 fa 25             	cmp    $0x25,%dl
  100746:	74 13                	je     10075b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100748:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10074c:	0f b6 d2             	movzbl %dl,%edx
  10074f:	89 f0                	mov    %esi,%eax
  100751:	e8 59 ff ff ff       	call   1006af <console_putc>
  100756:	e9 45 03 00 00       	jmp    100aa0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10075b:	47                   	inc    %edi
  10075c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100763:	00 
  100764:	eb 12                	jmp    100778 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100766:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100767:	8a 11                	mov    (%ecx),%dl
  100769:	84 d2                	test   %dl,%dl
  10076b:	74 1a                	je     100787 <console_vprintf+0x5c>
  10076d:	89 e8                	mov    %ebp,%eax
  10076f:	38 c2                	cmp    %al,%dl
  100771:	75 f3                	jne    100766 <console_vprintf+0x3b>
  100773:	e9 3f 03 00 00       	jmp    100ab7 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100778:	8a 17                	mov    (%edi),%dl
  10077a:	84 d2                	test   %dl,%dl
  10077c:	74 0b                	je     100789 <console_vprintf+0x5e>
  10077e:	b9 0c 0b 10 00       	mov    $0x100b0c,%ecx
  100783:	89 d5                	mov    %edx,%ebp
  100785:	eb e0                	jmp    100767 <console_vprintf+0x3c>
  100787:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100789:	8d 42 cf             	lea    -0x31(%edx),%eax
  10078c:	3c 08                	cmp    $0x8,%al
  10078e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100795:	00 
  100796:	76 13                	jbe    1007ab <console_vprintf+0x80>
  100798:	eb 1d                	jmp    1007b7 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10079a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10079f:	0f be c0             	movsbl %al,%eax
  1007a2:	47                   	inc    %edi
  1007a3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007ab:	8a 07                	mov    (%edi),%al
  1007ad:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007b0:	80 fa 09             	cmp    $0x9,%dl
  1007b3:	76 e5                	jbe    10079a <console_vprintf+0x6f>
  1007b5:	eb 18                	jmp    1007cf <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007b7:	80 fa 2a             	cmp    $0x2a,%dl
  1007ba:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007c1:	ff 
  1007c2:	75 0b                	jne    1007cf <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007c4:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007c7:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007c8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007cb:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007cf:	83 cd ff             	or     $0xffffffff,%ebp
  1007d2:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007d5:	75 37                	jne    10080e <console_vprintf+0xe3>
			++format;
  1007d7:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007d8:	31 ed                	xor    %ebp,%ebp
  1007da:	8a 07                	mov    (%edi),%al
  1007dc:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007df:	80 fa 09             	cmp    $0x9,%dl
  1007e2:	76 0d                	jbe    1007f1 <console_vprintf+0xc6>
  1007e4:	eb 17                	jmp    1007fd <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007e6:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007e9:	0f be c0             	movsbl %al,%eax
  1007ec:	47                   	inc    %edi
  1007ed:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007f1:	8a 07                	mov    (%edi),%al
  1007f3:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007f6:	80 fa 09             	cmp    $0x9,%dl
  1007f9:	76 eb                	jbe    1007e6 <console_vprintf+0xbb>
  1007fb:	eb 11                	jmp    10080e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007fd:	3c 2a                	cmp    $0x2a,%al
  1007ff:	75 0b                	jne    10080c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100801:	83 c3 04             	add    $0x4,%ebx
				++format;
  100804:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100805:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100808:	85 ed                	test   %ebp,%ebp
  10080a:	79 02                	jns    10080e <console_vprintf+0xe3>
  10080c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10080e:	8a 07                	mov    (%edi),%al
  100810:	3c 64                	cmp    $0x64,%al
  100812:	74 34                	je     100848 <console_vprintf+0x11d>
  100814:	7f 1d                	jg     100833 <console_vprintf+0x108>
  100816:	3c 58                	cmp    $0x58,%al
  100818:	0f 84 a2 00 00 00    	je     1008c0 <console_vprintf+0x195>
  10081e:	3c 63                	cmp    $0x63,%al
  100820:	0f 84 bf 00 00 00    	je     1008e5 <console_vprintf+0x1ba>
  100826:	3c 43                	cmp    $0x43,%al
  100828:	0f 85 d0 00 00 00    	jne    1008fe <console_vprintf+0x1d3>
  10082e:	e9 a3 00 00 00       	jmp    1008d6 <console_vprintf+0x1ab>
  100833:	3c 75                	cmp    $0x75,%al
  100835:	74 4d                	je     100884 <console_vprintf+0x159>
  100837:	3c 78                	cmp    $0x78,%al
  100839:	74 5c                	je     100897 <console_vprintf+0x16c>
  10083b:	3c 73                	cmp    $0x73,%al
  10083d:	0f 85 bb 00 00 00    	jne    1008fe <console_vprintf+0x1d3>
  100843:	e9 86 00 00 00       	jmp    1008ce <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100848:	83 c3 04             	add    $0x4,%ebx
  10084b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10084e:	89 d1                	mov    %edx,%ecx
  100850:	c1 f9 1f             	sar    $0x1f,%ecx
  100853:	89 0c 24             	mov    %ecx,(%esp)
  100856:	31 ca                	xor    %ecx,%edx
  100858:	55                   	push   %ebp
  100859:	29 ca                	sub    %ecx,%edx
  10085b:	68 14 0b 10 00       	push   $0x100b14
  100860:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100865:	8d 44 24 40          	lea    0x40(%esp),%eax
  100869:	e8 90 fe ff ff       	call   1006fe <fill_numbuf>
  10086e:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100872:	58                   	pop    %eax
  100873:	5a                   	pop    %edx
  100874:	ba 01 00 00 00       	mov    $0x1,%edx
  100879:	8b 04 24             	mov    (%esp),%eax
  10087c:	83 e0 01             	and    $0x1,%eax
  10087f:	e9 a5 00 00 00       	jmp    100929 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100884:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100887:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10088c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10088f:	55                   	push   %ebp
  100890:	68 14 0b 10 00       	push   $0x100b14
  100895:	eb 11                	jmp    1008a8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100897:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10089a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10089d:	55                   	push   %ebp
  10089e:	68 28 0b 10 00       	push   $0x100b28
  1008a3:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008a8:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008ac:	e8 4d fe ff ff       	call   1006fe <fill_numbuf>
  1008b1:	ba 01 00 00 00       	mov    $0x1,%edx
  1008b6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008ba:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008bc:	59                   	pop    %ecx
  1008bd:	59                   	pop    %ecx
  1008be:	eb 69                	jmp    100929 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008c0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008c3:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008c6:	55                   	push   %ebp
  1008c7:	68 14 0b 10 00       	push   $0x100b14
  1008cc:	eb d5                	jmp    1008a3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008ce:	83 c3 04             	add    $0x4,%ebx
  1008d1:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008d4:	eb 40                	jmp    100916 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008d6:	83 c3 04             	add    $0x4,%ebx
  1008d9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008dc:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008e0:	e9 bd 01 00 00       	jmp    100aa2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008e5:	83 c3 04             	add    $0x4,%ebx
  1008e8:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008eb:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008ef:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008f4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008f8:	88 44 24 24          	mov    %al,0x24(%esp)
  1008fc:	eb 27                	jmp    100925 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008fe:	84 c0                	test   %al,%al
  100900:	75 02                	jne    100904 <console_vprintf+0x1d9>
  100902:	b0 25                	mov    $0x25,%al
  100904:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100908:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10090d:	80 3f 00             	cmpb   $0x0,(%edi)
  100910:	74 0a                	je     10091c <console_vprintf+0x1f1>
  100912:	8d 44 24 24          	lea    0x24(%esp),%eax
  100916:	89 44 24 04          	mov    %eax,0x4(%esp)
  10091a:	eb 09                	jmp    100925 <console_vprintf+0x1fa>
				format--;
  10091c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100920:	4f                   	dec    %edi
  100921:	89 54 24 04          	mov    %edx,0x4(%esp)
  100925:	31 d2                	xor    %edx,%edx
  100927:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100929:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10092b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10092e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100935:	74 1f                	je     100956 <console_vprintf+0x22b>
  100937:	89 04 24             	mov    %eax,(%esp)
  10093a:	eb 01                	jmp    10093d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10093c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10093d:	39 e9                	cmp    %ebp,%ecx
  10093f:	74 0a                	je     10094b <console_vprintf+0x220>
  100941:	8b 44 24 04          	mov    0x4(%esp),%eax
  100945:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100949:	75 f1                	jne    10093c <console_vprintf+0x211>
  10094b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10094e:	89 0c 24             	mov    %ecx,(%esp)
  100951:	eb 1f                	jmp    100972 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100953:	42                   	inc    %edx
  100954:	eb 09                	jmp    10095f <console_vprintf+0x234>
  100956:	89 d1                	mov    %edx,%ecx
  100958:	8b 14 24             	mov    (%esp),%edx
  10095b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10095f:	8b 44 24 04          	mov    0x4(%esp),%eax
  100963:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100967:	75 ea                	jne    100953 <console_vprintf+0x228>
  100969:	8b 44 24 08          	mov    0x8(%esp),%eax
  10096d:	89 14 24             	mov    %edx,(%esp)
  100970:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100972:	85 c0                	test   %eax,%eax
  100974:	74 0c                	je     100982 <console_vprintf+0x257>
  100976:	84 d2                	test   %dl,%dl
  100978:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10097f:	00 
  100980:	75 24                	jne    1009a6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100982:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100987:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10098e:	00 
  10098f:	75 15                	jne    1009a6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100991:	8b 44 24 14          	mov    0x14(%esp),%eax
  100995:	83 e0 08             	and    $0x8,%eax
  100998:	83 f8 01             	cmp    $0x1,%eax
  10099b:	19 c9                	sbb    %ecx,%ecx
  10099d:	f7 d1                	not    %ecx
  10099f:	83 e1 20             	and    $0x20,%ecx
  1009a2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009a6:	3b 2c 24             	cmp    (%esp),%ebp
  1009a9:	7e 0d                	jle    1009b8 <console_vprintf+0x28d>
  1009ab:	84 d2                	test   %dl,%dl
  1009ad:	74 40                	je     1009ef <console_vprintf+0x2c4>
			zeros = precision - len;
  1009af:	2b 2c 24             	sub    (%esp),%ebp
  1009b2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009b6:	eb 3f                	jmp    1009f7 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009b8:	84 d2                	test   %dl,%dl
  1009ba:	74 33                	je     1009ef <console_vprintf+0x2c4>
  1009bc:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009c0:	83 e0 06             	and    $0x6,%eax
  1009c3:	83 f8 02             	cmp    $0x2,%eax
  1009c6:	75 27                	jne    1009ef <console_vprintf+0x2c4>
  1009c8:	45                   	inc    %ebp
  1009c9:	75 24                	jne    1009ef <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009cb:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009cd:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009d0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009d5:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009d8:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009db:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009df:	7d 0e                	jge    1009ef <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009e1:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009e5:	29 ca                	sub    %ecx,%edx
  1009e7:	29 c2                	sub    %eax,%edx
  1009e9:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009ed:	eb 08                	jmp    1009f7 <console_vprintf+0x2cc>
  1009ef:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009f6:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009f7:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009fb:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009fd:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a01:	2b 2c 24             	sub    (%esp),%ebp
  100a04:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a09:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a0c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a0f:	29 c5                	sub    %eax,%ebp
  100a11:	89 f0                	mov    %esi,%eax
  100a13:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a17:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a1b:	eb 0f                	jmp    100a2c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a1d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a21:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a26:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a27:	e8 83 fc ff ff       	call   1006af <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a2c:	85 ed                	test   %ebp,%ebp
  100a2e:	7e 07                	jle    100a37 <console_vprintf+0x30c>
  100a30:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a35:	74 e6                	je     100a1d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a37:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a3c:	89 c6                	mov    %eax,%esi
  100a3e:	74 23                	je     100a63 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a40:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a45:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a49:	e8 61 fc ff ff       	call   1006af <console_putc>
  100a4e:	89 c6                	mov    %eax,%esi
  100a50:	eb 11                	jmp    100a63 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a52:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a56:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a5b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a5c:	e8 4e fc ff ff       	call   1006af <console_putc>
  100a61:	eb 06                	jmp    100a69 <console_vprintf+0x33e>
  100a63:	89 f0                	mov    %esi,%eax
  100a65:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a69:	85 f6                	test   %esi,%esi
  100a6b:	7f e5                	jg     100a52 <console_vprintf+0x327>
  100a6d:	8b 34 24             	mov    (%esp),%esi
  100a70:	eb 15                	jmp    100a87 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a72:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a76:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a77:	0f b6 11             	movzbl (%ecx),%edx
  100a7a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a7e:	e8 2c fc ff ff       	call   1006af <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a83:	ff 44 24 04          	incl   0x4(%esp)
  100a87:	85 f6                	test   %esi,%esi
  100a89:	7f e7                	jg     100a72 <console_vprintf+0x347>
  100a8b:	eb 0f                	jmp    100a9c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a8d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a91:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a96:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a97:	e8 13 fc ff ff       	call   1006af <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a9c:	85 ed                	test   %ebp,%ebp
  100a9e:	7f ed                	jg     100a8d <console_vprintf+0x362>
  100aa0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100aa2:	47                   	inc    %edi
  100aa3:	8a 17                	mov    (%edi),%dl
  100aa5:	84 d2                	test   %dl,%dl
  100aa7:	0f 85 96 fc ff ff    	jne    100743 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100aad:	83 c4 38             	add    $0x38,%esp
  100ab0:	89 f0                	mov    %esi,%eax
  100ab2:	5b                   	pop    %ebx
  100ab3:	5e                   	pop    %esi
  100ab4:	5f                   	pop    %edi
  100ab5:	5d                   	pop    %ebp
  100ab6:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ab7:	81 e9 0c 0b 10 00    	sub    $0x100b0c,%ecx
  100abd:	b8 01 00 00 00       	mov    $0x1,%eax
  100ac2:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ac4:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ac5:	09 44 24 14          	or     %eax,0x14(%esp)
  100ac9:	e9 aa fc ff ff       	jmp    100778 <console_vprintf+0x4d>

00100ace <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100ace:	8d 44 24 10          	lea    0x10(%esp),%eax
  100ad2:	50                   	push   %eax
  100ad3:	ff 74 24 10          	pushl  0x10(%esp)
  100ad7:	ff 74 24 10          	pushl  0x10(%esp)
  100adb:	ff 74 24 10          	pushl  0x10(%esp)
  100adf:	e8 47 fc ff ff       	call   10072b <console_vprintf>
  100ae4:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100ae7:	c3                   	ret    
