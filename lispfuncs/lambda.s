.type	lambda, @function
lambda: # Stack-based
	movq	16(%rsp), %rdi
	call	scc_length
	incq	%rax
	negq	%rax
	pushq	%rax
	pushq	24(%rsp) # Arguments
	pushq	24(%rsp) # Body
	call	rpn
	call	subst_args
	movq	(%rsp), %rdi
	call	scc_length
	movq	%rax, %rdi
	leaq	24(,%rdi,8), %rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rsi
	popq	(%rdi)
	call	compile
	popq	(%rsp) # Drop second argument
	movq	%rax, 8(%rsp) # Replace first
	ret
