.type	reference, @function
reference: # Stack-based
	movq	ENV(%rip), %rdi
	movq	8(%rsp), %rsi
	call	env_assoc
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	ret
