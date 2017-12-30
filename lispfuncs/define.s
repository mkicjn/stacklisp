.type	define, @function
define:
	leaq	ENV(%rip), %rdi # &env
	movq	16(%rsp), %rsi # sym (arg2)
	movq	8(%rsp), %rdx # def (arg1)
	pushq	%rdx
	call	env_def
	popq	%rax
	movq	%rax, 16(%rsp)
	popq	(%rsp) # nip
	ret

.type	defglobal, @function
defglobal:
	leaq	GLOBAL_ENV(%rip), %rdi # &env
	movq	16(%rsp), %rsi # sym (arg2)
	movq	8(%rsp), %rdx # def (arg1)
	pushq	%rdx
	call	env_def
	popq	%rax
	movq	%rax, 16(%rsp)
	popq	(%rsp) # nip
	ret
