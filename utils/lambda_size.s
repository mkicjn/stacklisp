.type	lambda_size, @function
lambda_size: # Predicts the size of the compiled body, not including # of args or trailing 0xee
	xorq	%r8, %r8
	pushq	8(%rsp)
	.lambda_size_loop:
	movq	(%rsp), %rdi
	call	zornil
	cmpq	$1, %rax
	je	.lambda_size_ret
	pushq	(%rsp)
	call	car
	popq	%rax
	cmpq	$0, (%rax)
	jz	.lambda_size_list
	addq	$16, %r8
	call	cdr
	jmp	.lambda_size_loop
	.lambda_size_list:
	pushq	%r8
	pushq	%rax
	call	lambda_size
	popq	%r8
	addq	%r8, (%rsp)
	popq	%r8
	call	cdr
	jmp	.lambda_size_loop
	.lambda_size_ret:
	popq	8(%rsp)
	movq	%r8, 8(%rsp)
	ret
