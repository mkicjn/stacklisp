.type	lambda, @function
lambda: # Stack-based
	pushq	ENV(%rip)
	call	copy
	pushq	24(%rsp) # Recall arg1
	pushq	24(%rsp) # Recall arg2
	call	rpn
	call	subst_args
	movq	(%rsp), %rdi
	call	scc_length
	leaq	16(,%rax,8), %rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rsi
	call	compile
	pushq	%rax
	call	cons
	movq	24(%rsp), %rdi
	call	scc_length
	negq	%rax
	decq	%rax
	popq	%rdi
	movq	%rax, (%rdi)
	popq	(%rsp)
	movq	%rdi, 8(%rsp)
	ret
