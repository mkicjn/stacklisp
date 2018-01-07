.type	add, @function #|+|4|
add:
	xorq	%r8, %r8 # Running total
	.add_loop:
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	jne	.add_skip
	addq	8(%rdi), %r8
	.add_skip:
	popq	(%rsp)
	cmpq	$0, 8(%rsp)
	jnz	.add_loop
	movq	%r8, %rdi
	movq	$2, %rsi
	call	new_var
	popq	%rdi
	pushq	%rax
	pushq	%rdi
	ret
