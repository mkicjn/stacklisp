.type	random, @function
random:
	movq	seed(%rip), %rax
	movq	$1103515243, %rcx
	mulq	%rcx
	addq	$12345, %rax
	movq	$0xffffffff, %rcx
	xorq	%rdx, %rdx
	divq	%rcx
	movq	%rdx, seed(%rip)
	leaq	NIL(%rip), %rax
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	jne	.random_ret
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	8(%rdi)
	movq	%rdx, %rdi
	movq	$2, %rsi
	call	new_var
	.random_ret:
	movq	%rax, 8(%rsp)
	ret
