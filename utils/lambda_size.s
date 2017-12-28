.type	lambda_size, @function
lambda_size: # Standard calling convention. Predicts the size of the compiled body.
	pushq	$0
	pushq	%rdi
	call	rpn
	.lambda_size_loop:
	movq	(%rsp), %rdi
	call	zornil
	cmpq	$1, %rax
	je	.lambda_size_ret
	call	dup
	call	car
	popq	%rax
	cmpq	$0xff, %rax
	jle	.lambda_size_8
	addq	$8, 8(%rsp)
	.lambda_size_8:
	addq	$8, 8(%rsp)
	call	cdr
	jmp	.lambda_size_loop
	.lambda_size_ret:
	movq	8(%rsp), %rax
	addq	$16, %rsp
	addq	$16, %rax
	ret
