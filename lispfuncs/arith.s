.type	add, @function #|+|4|
add:
	xorq	%r8, %r8
	.add_loop:
	movq	8(%rsp), %rdi
	cmpq	$0xff, %rdi
	jle	.add_loop
	cmpq	$2, (%rdi)
	jne	.add_loop
	addq	8(%rdi), %r8
	popq	(%rsp)
	cmpq	$0, 8(%rsp)
	jne	.add_loop
	movq	%r8, %rdi
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
