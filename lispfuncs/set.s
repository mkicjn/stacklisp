.type	set, @function
set: # Stack-based
	movq	16(%rsp), %rdi # arg 1
	movq	8(%rsp), %rsi # arg 2
	movq	(%rdi), %rax
	movq	%rax, (%rsi)
	movq	8(%rdi), %rax
	movq	%rax, 8(%rsi)
	movq	16(%rdi), %rax
	movq	%rax, 16(%rsi)
	popq	(%rsp)
ret
