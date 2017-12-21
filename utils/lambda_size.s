.type	lambda_size, @function
lambda_size: # Predicts the size of the compiled body, not including # of args (8 bytes) or trailing 0x0 0x0 (16 bytes)
	xorq	%r8, %r8
	pushq	8(%rsp)
	.lambda_size_loop:
	call	zornil
	cmpq	$1, %rax
	je	.lambda_size_ret
	pushq	(%rsp)
	call	car
	popq	%rax
	cmpq	$0, (%rax)
	jg	.lambda_size_flag
	jz	.lambda_size_list
	addq	$8, %r8
	call	cdr
	jmp	.lambda_size_loop
	.lambda_size_flag:
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
