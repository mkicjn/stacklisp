.type	set, @function
set: # Stack-based
	movq	16(%rsp), %rdi
	call	eqnil
	cmpq	$1, %rax
	je	.set_nil
	movq	16(%rsp), %rdi
	movq	8(%rsp), %rsi
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	movq	8(%rsi), %rax
	movq	%rax, 8(%rdi)
	movq	16(%rsi), %rax
	movq	%rax, 16(%rdi)
	popq	(%rsp)
	.set_nil:
	ret
