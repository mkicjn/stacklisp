.type	lambda, @function
lambda: # Stack-based
	movq	16(%rsp), %rdi
	call	scc_length
	negq	%rax
	decq	%rax
	pushq	%rax
	pushq	24(%rsp) # Arguments
	pushq	24(%rsp) # Body
	call	rpn
	call	subst_args
	movq	(%rsp), %rdi
	call	scc_length
	leaq	32(,%rax,8), %rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rsi
	popq	(%rdi)
	call	compile
	popq	(%rsp) # Drop second argument
	movq	%rax, 8(%rsp) # Replace first
	ret
