.data
# Pointers to a list (leaq for &env, movq for env)
GLOBAL_ENV:
	.quad	DICT
ENV:
	.quad	DICT
.text

.type	env_assoc, @function
env_assoc: # Standard calling convention
	cmpq	$1, (%rsi) # Catch invalid definitions
	jne	.env_assoc_err
	pushq	%rsi # sym
	pushq	%rdi # env
	.env_assoc_loop:
	pushq	8(%rsp)
	pushq	8(%rsp) # Duplicate both arguments
	call	car
	call	car # Get token for definition
	call	eq
	popq	%rdi
	call	zornil
	cmpq	$1, %rax # Check definition match
	jne	.env_assoc_ret
	call	cdr
	movq	(%rsp), %rdi
	call	zornil
	cmpq	$1, %rax
	je	.env_assoc_undef
	jmp	.env_assoc_loop
	.env_assoc_ret:
	call	car
	popq	%rax # Symbol-definition pair
	addq	$8, %rsp # drop
	ret
	.env_assoc_undef:
	addq	$16, %rsp # 2drop
	.env_assoc_err:
	leaq	NIL(%rip), %rax
	ret

.type	env_def, @function
env_def: # Standard calling convention, 3 args. No intended return value.
	cmpq	$1, (%rsi) # Catch invalid definitions
	jne	.env_def_err
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
	popq	16(%rax)
	addq	$16, %rsp
	ret
	.env_def_add:
	call	cons
	movq	8(%rsp), %rax # over
	pushq	(%rax)
	call	cons
	popq	%rsi
	popq	%rdi
	movq	%rsi, (%rdi) # env=cons(cons(sym,def),env)
	.env_def_err:
	ret
