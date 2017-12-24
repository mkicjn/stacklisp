.type	set, @function
set: # Stack-based
	movq	16(%rsp), %rdi # arg 1
	movq	8(%rsp), %rsi # arg 2
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	movq	8(%rsi), %rax
	movq	%rax, 8(%rdi)
	movq	16(%rsi), %rax
	movq	%rax, 16(%rdi)
	popq	(%rsp)
ret
