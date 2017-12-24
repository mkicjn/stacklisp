.data
GLOBAL_ENV: # Pointer to list. leaq for &env, movq for env
	.quad	NIL
.text

.type	init_env, @function
init_global_env:
	leaq	GLOBAL_ENV(%rip), %rax
	leaq	NIL(%rip), %rdx
	movq	%rdx, (%rax)
	ret

.type	env_assoc, @function
env_assoc: # Standard calling convention
	pushq	%rsi
	pushq	%rdi
	.env_assoc_loop:
	pushq	8(%rsp)
	pushq	8(%rsp) # Duplicate both arguments
	call	car
	call	car
	call	eq
	popq	%rdi
	call	zornil
	cmpq	$1, %rax
	jne	.env_assoc_ret
	call	cdr
	movq	(%rsp), %rdi
	call	zornil
	cmpq	$1, %rax
	je	.env_assoc_undef
	jmp	.env_assoc_loop
	.env_assoc_ret:
	call	car
	popq	%rax
	addq	$8, %rsp # drop
	popq	(%rsp) # nip
	ret
	.env_assoc_undef:
	addq	$16, %rsp # 2drop
	leaq	NIL(%rip), %rax
	ret

.type	env_def, @function
env_def: # Standard calling convention, 3 args. No intended return value.
	pushq	%rdi # &env
	pushq	%rsi # sym
	pushq	%rdx # def
	movq	(%rdi), %rdi
	call	env_assoc
	pushq	%rax
	movq	%rax, %rdi
	call	zornil
	cmpq	$1, %rax
	popq	%rax # (sym . def)
	je	.env_def_add
	popq	16(%rax) # rplacd
	addq	$8, %rsp # drop
	ret
	.env_def_add:
	call	cons
	movq	8(%rsp), %rax # over
	pushq	(%rax)
	call	cons
	popq	%rsi
	popq	%rdi
	movq	%rsi, (%rdi) # env=cons(cons(sym,def),env)
	ret
