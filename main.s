	.file	"main.c"
	.text
	.globl	msgid
	.bss
	.align 4
	.type	msgid, @object
	.size	msgid, 4
msgid:
	.zero	4
	.globl	config
	.align 16
	.type	config, @object
	.size	config, 20
config:
	.zero	20
	.globl	TARGETS
	.section	.rodata
	.align 8
.LC0:
	.string	"Robbing banks and financial institutions"
.LC1:
	.string	"Robbing gold/jewelry shops"
	.align 8
.LC2:
	.string	"Drug trafficking (buying and selling)"
.LC3:
	.string	"Robbing expensive art work"
	.align 8
.LC4:
	.string	"Kidnapping wealthy people and asking for ransoms"
.LC5:
	.string	"Blackmailing wealthy people"
.LC6:
	.string	"Arm trafficking"
	.section	.data.rel.local,"aw"
	.align 32
	.type	TARGETS, @object
	.size	TARGETS, 56
TARGETS:
	.quad	.LC0
	.quad	.LC1
	.quad	.LC2
	.quad	.LC3
	.quad	.LC4
	.quad	.LC5
	.quad	.LC6
	.section	.rodata
.LC7:
	.string	"r"
.LC8:
	.string	"config.txt not found"
.LC9:
	.string	"number_of_gangs"
.LC10:
	.string	"number_of_gangs=%d"
.LC11:
	.string	"min_members_per_gang"
.LC12:
	.string	"min_members_per_gang=%d"
.LC13:
	.string	"max_members_per_gang"
.LC14:
	.string	"max_members_per_gang=%d"
.LC15:
	.string	"rank_levels"
.LC16:
	.string	"rank_levels=%d"
.LC17:
	.string	"secret_agent_probability"
.LC18:
	.string	"secret_agent_probability=%d"
	.text
	.globl	read_config
	.type	read_config, @function
read_config:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$304, %rsp
	movq	%rdi, -296(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-296(%rbp), %rax
	leaq	.LC7(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -280(%rbp)
	cmpq	$0, -280(%rbp)
	jne	.L8
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L9:
	leaq	-272(%rbp), %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L4
	leaq	-272(%rbp), %rax
	leaq	config(%rip), %rdx
	leaq	.LC10(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
.L4:
	leaq	-272(%rbp), %rax
	leaq	.LC11(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L5
	leaq	-272(%rbp), %rax
	leaq	4+config(%rip), %rdx
	leaq	.LC12(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
.L5:
	leaq	-272(%rbp), %rax
	leaq	.LC13(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L6
	leaq	-272(%rbp), %rax
	leaq	8+config(%rip), %rdx
	leaq	.LC14(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
.L6:
	leaq	-272(%rbp), %rax
	leaq	.LC15(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L7
	leaq	-272(%rbp), %rax
	leaq	12+config(%rip), %rdx
	leaq	.LC16(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
.L7:
	leaq	-272(%rbp), %rax
	leaq	.LC17(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L8
	leaq	-272(%rbp), %rax
	leaq	16+config(%rip), %rdx
	leaq	.LC18(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
.L8:
	movq	-280(%rbp), %rdx
	leaq	-272(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L9
	movq	-280(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	read_config, .-read_config
	.section	.rodata
	.align 8
.LC19:
	.string	"\360\237\232\250 Gang discovered Agent %d in Rank %d! Eliminating...\n"
	.text
	.globl	investigate_members
	.type	investigate_members, @function
investigate_members:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movq	%rcx, -40(%rbp)
	movl	-28(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.L12
.L14:
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L13
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$1374389535, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$5, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	movl	%edx, -12(%rbp)
	movl	-12(%rbp), %edx
	imull	$100, %edx, %edx
	subl	%edx, %eax
	movl	%eax, -12(%rbp)
	cmpl	$49, -12(%rbp)
	jg	.L13
	movq	-8(%rbp), %rax
	movl	4(%rax), %edx
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC19(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-32(%rbp), %eax
	movl	%eax, %edi
	call	semaphore_wait@PLT
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	leal	1(%rax), %edx
	movq	-40(%rbp), %rax
	movl	%edx, 8(%rax)
	movl	-32(%rbp), %eax
	movl	%eax, %edi
	call	semaphore_signal@PLT
	movq	-8(%rbp), %rax
	movl	$1, 16(%rax)
.L13:
	subl	$1, -16(%rbp)
.L12:
	cmpl	$0, -16(%rbp)
	jns	.L14
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	investigate_members, .-investigate_members
	.section	.rodata
	.align 8
.LC20:
	.string	"\360\237\224\215 Member %d geng id %d :  Starting...\n"
.LC21:
	.string	"YES"
.LC22:
	.string	"NO"
	.align 8
.LC23:
	.string	"\360\237\221\244 Member %d | Rank: %d | Secret Agent: %s | geng id : %d\n"
	.align 8
.LC24:
	.string	"\360\237\224\247 Member %d in Gang %d preparation: %d/%d\n"
	.align 8
.LC25:
	.string	"\360\237\244\220 Suspicion: %d | Knowledge: %d (Agent %d in Gang %d)\n"
	.align 8
.LC26:
	.string	"\360\237\223\250 Agent %d in Gang %d sent report: Suspicion=%d, Knowledge=%d\n"
	.text
	.globl	member_thread
	.type	member_thread, @function
member_thread:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-72(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-48(%rbp), %rax
	movl	20(%rax), %eax
	movl	%eax, -64(%rbp)
	movq	-40(%rbp), %rax
	movl	12(%rax), %eax
	leal	1(%rax), %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	addl	$1, %eax
	movl	%eax, %esi
	leaq	.LC20(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movl	12(%rax), %eax
	leal	1(%rax), %edi
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L16
	leaq	.LC21(%rip), %rax
	jmp	.L17
.L16:
	leaq	.LC22(%rip), %rax
.L17:
	movq	-40(%rbp), %rdx
	movl	4(%rdx), %edx
	movq	-40(%rbp), %rcx
	movl	(%rcx), %esi
	movl	%edi, %r8d
	movq	%rax, %rcx
	leaq	.LC23(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	call	rand@PLT
	movl	%eax, %edx
	movslq	%edx, %rax
	imulq	$780903145, %rax, %rax
	shrq	$32, %rax
	sarl	%eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	subl	%eax, %edx
	movl	%edx, -60(%rbp)
	movq	-40(%rbp), %rax
	movl	12(%rax), %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	-64(%rbp), %esi
	movl	-60(%rbp), %ecx
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC24(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	testl	%eax, %eax
	je	.L18
	movl	$1, %edi
	call	sleep@PLT
	movl	$5, -56(%rbp)
	call	rand@PLT
	movl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1717986919, %rax, %rax
	shrq	$32, %rax
	sarl	$2, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	addl	%eax, %eax
	subl	%eax, %edx
	movl	%edx, -52(%rbp)
	movq	-40(%rbp), %rax
	movl	12(%rax), %esi
	movq	-40(%rbp), %rax
	movl	(%rax), %ecx
	movl	-52(%rbp), %edx
	movl	-56(%rbp), %eax
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC25(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$4, -56(%rbp)
	jle	.L18
	movq	$1, -32(%rbp)
	movq	-40(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, -24(%rbp)
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -20(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	msgid(%rip), %eax
	leaq	-32(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	send_agent_report@PLT
	movq	-40(%rbp), %rax
	movl	12(%rax), %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	-52(%rbp), %esi
	movl	-56(%rbp), %ecx
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC26(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L18:
	movl	$0, %edi
	call	pthread_exit@PLT
	.cfi_endproc
.LFE8:
	.size	member_thread, .-member_thread
	.section	.rodata
	.align 8
.LC27:
	.string	"\360\237\232\251 Gang %d: Creating %d members\n"
	.align 8
.LC28:
	.string	"\360\237\216\257 Gang %d Leader (Member %d) selected target: %s\n"
	.align 8
.LC29:
	.string	"\342\217\263 Gang %d preparing for: '%s' | Required prep: %d | Time: %d sec\n"
.LC31:
	.string	"\342\234\205 Gang %d succeeded in: %s\n"
	.align 8
.LC32:
	.string	"\342\235\214 Gang %d failed to execute: %s\n"
.LC33:
	.string	"\342\234\205 Gang %d initialized.\n"
	.text
	.globl	create_gang
	.type	create_gang, @function
create_gang:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$112, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movl	%edi, -116(%rbp)
	movl	%esi, -120(%rbp)
	movq	%rdx, -128(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	%rsp, %rax
	movq	%rax, %r12
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %ebx
	call	getpid@PLT
	addl	%ebx, %eax
	movl	%eax, %edi
	call	srand@PLT
	movl	4+config(%rip), %ebx
	call	rand@PLT
	movl	8+config(%rip), %ecx
	movl	4+config(%rip), %edx
	subl	%edx, %ecx
	leal	1(%rcx), %edi
	cltd
	idivl	%edi
	movl	%edx, %ecx
	movl	%ecx, %eax
	addl	%ebx, %eax
	movl	%eax, -88(%rbp)
	movl	-116(%rbp), %eax
	leal	1(%rax), %ecx
	movl	-88(%rbp), %eax
	movl	%eax, %edx
	movl	%ecx, %esi
	leaq	.LC27(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-88(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -56(%rbp)
	cltq
	leaq	0(,%rax,8), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %ebx
	movl	$0, %edx
	divq	%rbx
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L21:
	cmpq	%rdx, %rsp
	je	.L22
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L21
.L22:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L23
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L23:
	movq	%rsp, %rax
	addq	$7, %rax
	shrq	$3, %rax
	salq	$3, %rax
	movq	%rax, -48(%rbp)
	movl	-88(%rbp), %ecx
	movslq	%ecx, %rax
	subq	$1, %rax
	movq	%rax, -40(%rbp)
	movslq	%ecx, %rax
	movq	%rax, %rsi
	movl	$0, %edi
	movq	%rsi, %rax
	movq	%rdi, %rdx
	shldq	$1, %rax, %rdx
	addq	%rax, %rax
	addq	%rsi, %rax
	adcq	%rdi, %rdx
	shldq	$6, %rax, %rdx
	salq	$6, %rax
	movslq	%ecx, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movslq	%ecx, %rax
	movq	%rax, %rsi
	movl	$0, %edi
	movq	%rsi, %rax
	movq	%rdi, %rdx
	shldq	$1, %rax, %rdx
	addq	%rax, %rax
	addq	%rsi, %rax
	adcq	%rdi, %rdx
	shldq	$6, %rax, %rdx
	salq	$6, %rax
	movslq	%ecx, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	%rax, %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %ebx
	movl	$0, %edx
	divq	%rbx
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L24:
	cmpq	%rdx, %rsp
	je	.L25
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L24
.L25:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L26
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L26:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -32(%rbp)
	movq	$0, -64(%rbp)
	call	rand@PLT
	movl	%eax, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$30, %eax
	addl	%eax, %edx
	andl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	addl	$3, %eax
	movl	%eax, -84(%rbp)
	call	rand@PLT
	movl	%eax, %ecx
	movslq	%ecx, %rax
	imulq	$715827883, %rax, %rax
	shrq	$32, %rax
	movq	%rax, %rdx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	leal	5(%rdx), %eax
	movl	%eax, -80(%rbp)
	movl	$0, -108(%rbp)
	jmp	.L27
.L30:
	movq	-32(%rbp), %rcx
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	leaq	(%rcx,%rax), %rdx
	movl	-108(%rbp), %eax
	movl	%eax, (%rdx)
	movq	-32(%rbp), %rcx
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rcx, %rax
	leaq	12(%rax), %rdx
	movl	-116(%rbp), %eax
	movl	%eax, (%rdx)
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$1374389535, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$5, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	imull	$100, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	movl	16+config(%rip), %eax
	cmpl	%eax, %edx
	setl	%al
	movzbl	%al, %ecx
	movq	-32(%rbp), %rsi
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rsi, %rax
	addq	$8, %rax
	movl	%ecx, (%rax)
	movl	12+config(%rip), %eax
	movl	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	-108(%rbp), %eax
	imull	-68(%rbp), %eax
	cltd
	idivl	-88(%rbp)
	subl	%eax, %ecx
	movq	-32(%rbp), %rsi
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rsi, %rax
	addq	$4, %rax
	movl	%ecx, (%rax)
	movq	-32(%rbp), %rcx
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rcx, %rax
	addq	$4, %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jns	.L28
	movq	-32(%rbp), %rcx
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rcx, %rax
	addq	$4, %rax
	movl	$0, (%rax)
.L28:
	movq	-32(%rbp), %rcx
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rcx, %rax
	addq	$4, %rax
	movl	(%rax), %edx
	movl	12+config(%rip), %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jne	.L29
	cmpq	$0, -64(%rbp)
	jne	.L29
	call	rand@PLT
	movslq	%eax, %rcx
	movabsq	$2635249153387078803, %rdx
	movq	%rcx, %rax
	mulq	%rdx
	movq	%rcx, %rax
	subq	%rdx, %rax
	shrq	%rax
	addq	%rdx, %rax
	shrq	$2, %rax
	movq	%rax, %rdx
	salq	$3, %rdx
	subq	%rax, %rdx
	movq	%rcx, %rax
	subq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	TARGETS(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-32(%rbp), %rcx
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	movl	-116(%rbp), %edx
	leal	1(%rdx), %esi
	movq	-64(%rbp), %rdx
	movq	%rdx, %rcx
	movl	%eax, %edx
	leaq	.LC28(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L29:
	movq	-32(%rbp), %rcx
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	addq	%rcx, %rax
	leaq	20(%rax), %rdx
	movl	-80(%rbp), %eax
	movl	%eax, (%rdx)
	movl	-108(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	movq	-32(%rbp), %rdx
	addq	%rax, %rdx
	movl	-108(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-48(%rbp), %rax
	addq	%rcx, %rax
	movq	%rdx, %rcx
	leaq	member_thread(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	addl	$1, -108(%rbp)
.L27:
	movl	-108(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jl	.L30
	cmpq	$0, -64(%rbp)
	jne	.L31
	call	rand@PLT
	movslq	%eax, %rcx
	movabsq	$2635249153387078803, %rdx
	movq	%rcx, %rax
	mulq	%rdx
	movq	%rcx, %rax
	subq	%rdx, %rax
	shrq	%rax
	addq	%rdx, %rax
	shrq	$2, %rax
	movq	%rax, %rdx
	salq	$3, %rdx
	subq	%rax, %rdx
	movq	%rcx, %rax
	subq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	TARGETS(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -64(%rbp)
.L31:
	movl	-116(%rbp), %eax
	leal	1(%rax), %esi
	movl	-84(%rbp), %ecx
	movl	-80(%rbp), %edx
	movq	-64(%rbp), %rax
	movl	%ecx, %r8d
	movl	%edx, %ecx
	movq	%rax, %rdx
	leaq	.LC29(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -104(%rbp)
	jmp	.L32
.L33:
	movq	-48(%rbp), %rax
	movl	-104(%rbp), %edx
	movslq	%edx, %rdx
	movq	(%rax,%rdx,8), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	addl	$1, -104(%rbp)
.L32:
	movl	-104(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jl	.L33
	movl	$0, -100(%rbp)
	movl	$0, -96(%rbp)
	jmp	.L34
.L36:
	call	rand@PLT
	movl	%eax, %edx
	movslq	%edx, %rax
	imulq	$780903145, %rax, %rax
	shrq	$32, %rax
	sarl	%eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	movl	%eax, -72(%rbp)
	movl	-72(%rbp), %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	subl	%eax, %edx
	movl	%edx, -72(%rbp)
	movl	-72(%rbp), %eax
	cmpl	-80(%rbp), %eax
	jl	.L35
	addl	$1, -100(%rbp)
.L35:
	addl	$1, -96(%rbp)
.L34:
	movl	-96(%rbp), %eax
	cmpl	-88(%rbp), %eax
	jl	.L36
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-100(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2ssl	-88(%rbp), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -76(%rbp)
	movl	$0, -92(%rbp)
	pxor	%xmm0, %xmm0
	cvtss2sd	-76(%rbp), %xmm0
	comisd	.LC30(%rip), %xmm0
	jb	.L37
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$1374389535, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$5, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	imull	$100, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	cmpl	$20, %edx
	jle	.L37
	movl	$1, -92(%rbp)
.L37:
	movl	-120(%rbp), %eax
	movl	%eax, %edi
	call	semaphore_wait@PLT
	cmpl	$0, -92(%rbp)
	je	.L39
	movl	-116(%rbp), %eax
	leal	1(%rax), %ecx
	movq	-64(%rbp), %rax
	movq	%rax, %rdx
	movl	%ecx, %esi
	leaq	.LC31(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-128(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-128(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L40
.L39:
	movl	-116(%rbp), %eax
	leal	1(%rax), %ecx
	movq	-64(%rbp), %rax
	movq	%rax, %rdx
	movl	%ecx, %esi
	leaq	.LC32(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-128(%rbp), %rax
	movl	4(%rax), %eax
	leal	1(%rax), %edx
	movq	-128(%rbp), %rax
	movl	%edx, 4(%rax)
.L40:
	movl	-120(%rbp), %eax
	movl	%eax, %edi
	call	semaphore_signal@PLT
	movl	-116(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	leaq	.LC33(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	%r12, %rsp
	nop
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L41
	call	__stack_chk_fail@PLT
.L41:
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	create_gang, .-create_gang
	.section	.rodata
.LC34:
	.string	"Usage: %s config.txt\n"
	.align 8
.LC35:
	.string	"\360\237\223\204 Loaded config: %d gangs, members range [%d - %d], ranks: %d\n"
	.align 8
.LC36:
	.string	"\360\237\232\223 Police is collecting reports:"
	.align 8
.LC37:
	.string	"\360\237\223\235 Report from Agent %d (Gang %d): Suspicion=%d, Knowledge=%d\n"
	.align 8
.LC38:
	.string	"\360\237\232\224 Total reports received: %d\n"
.LC39:
	.string	"\360\237\223\212 Simulation Summary:"
.LC40:
	.string	"\342\234\205 Successful Plans: %d\n"
.LC41:
	.string	"\342\235\214 Failed Plans: %d\n"
	.align 8
.LC42:
	.string	"\360\237\225\265\357\270\217\342\200\215\342\231\202\357\270\217 Captured Agents: %d\n"
	.align 8
.LC43:
	.string	"\360\237\216\257 All gangs have been initialized."
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -68(%rbp)
	je	.L44
	movq	-80(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	leaq	.LC34(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L44:
	movq	-80(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	read_config
	movl	$0, %eax
	call	create_shared_memory@PLT
	movl	%eax, -52(%rbp)
	movl	$0, %eax
	call	create_semaphore@PLT
	movl	%eax, -48(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, %edi
	call	attach_shared_memory@PLT
	movq	%rax, -40(%rbp)
	movl	$0, %eax
	call	create_message_queue@PLT
	movl	%eax, msgid(%rip)
	movq	-40(%rbp), %rax
	movl	$0, (%rax)
	movq	-40(%rbp), %rax
	movl	$0, 4(%rax)
	movq	-40(%rbp), %rax
	movl	$0, 8(%rax)
	movl	12+config(%rip), %esi
	movl	8+config(%rip), %ecx
	movl	4+config(%rip), %edx
	movl	config(%rip), %eax
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC35(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -64(%rbp)
	jmp	.L45
.L47:
	call	fork@PLT
	movl	%eax, -44(%rbp)
	cmpl	$0, -44(%rbp)
	jne	.L46
	movq	-40(%rbp), %rdx
	movl	-48(%rbp), %ecx
	movl	-64(%rbp), %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	create_gang
	movl	$0, %edi
	call	exit@PLT
.L46:
	addl	$1, -64(%rbp)
.L45:
	movl	config(%rip), %eax
	cmpl	%eax, -64(%rbp)
	jl	.L47
	movl	$0, -60(%rbp)
	jmp	.L48
.L49:
	movl	$0, %edi
	call	wait@PLT
	addl	$1, -60(%rbp)
.L48:
	movl	config(%rip), %eax
	cmpl	%eax, -60(%rbp)
	jl	.L49
	movl	$0, -56(%rbp)
	leaq	.LC36(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L50
.L51:
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %ecx
	movl	-24(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%esi, %r8d
	movl	%eax, %esi
	leaq	.LC37(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -56(%rbp)
.L50:
	movl	msgid(%rip), %eax
	leaq	-32(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	receive_agent_report@PLT
	cmpl	$-1, %eax
	jne	.L51
	movl	msgid(%rip), %eax
	movl	%eax, %edi
	call	destroy_message_queue@PLT
	movl	-56(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC38(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC39(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	leaq	.LC40(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, %esi
	leaq	.LC41(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, %esi
	leaq	.LC42(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	detach_shared_memory@PLT
	movl	-52(%rbp), %eax
	movl	%eax, %edi
	call	destroy_shared_memory@PLT
	movl	-48(%rbp), %eax
	movl	%eax, %edi
	call	destroy_semaphore@PLT
	leaq	.LC43(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L53
	call	__stack_chk_fail@PLT
.L53:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC30:
	.long	1717986918
	.long	1072064102
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
