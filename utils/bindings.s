.type	binding, @function
local_binding: # Stack-based
	movq	ENV(%rip), %rdi
	movq	8(%rsp), %rsi
	call	env_assoc
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	ret

.type	binding, @function
global_binding: # Stack-based
	movq	GLOBAL_ENV(%rip), %rdi
	movq	8(%rsp), %rsi
	call	env_assoc
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	ret
