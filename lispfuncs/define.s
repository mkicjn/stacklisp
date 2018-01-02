.type	define, @function
define:
	movq	16(%rsp), %rsi # sym (arg2)
	leaq	NIL(%rip), %rax
	cmpq	%rax, %rsi
	je	.def_const
	leaq	T(%rip), %rax
	cmpq	%rax, %rsi
	je	.def_const
	leaq	ENV(%rip), %rdi # &env
	movq	8(%rsp), %rdx # def (arg1)
	pushq	%rdx
	call	env_def
	popq	%rax
	movq	%rax, 16(%rsp)
	popq	(%rsp) # nip
	ret

.type	defglobal, @function
defglobal:
	movq	16(%rsp), %rsi # sym (arg2)
	leaq	NIL(%rip), %rax
	cmpq	%rax, %rsi
	je	.def_const
	leaq	T(%rip), %rax
	cmpq	%rax, %rsi
	je	.def_const
	leaq	GLOBAL_ENV(%rip), %rdi # &env
	movq	8(%rsp), %rdx # def (arg1)
	pushq	%rdx
	call	env_def
	popq	%rax
	movq	%rax, 16(%rsp)
	popq	(%rsp) # nip
	ret

.def_const:
	popq	(%rsp)
	ret
