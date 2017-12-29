self_op_str:
	.string	"@"
self_op_sym:
	.quad	1,self_op_str,0
self_op_cell:
	.quad	0,self_op_sym,0
arg_dict_seed:
	.quad	0,self_op_cell,NIL

.type	subst_args, @function
subst_args: # Stack-based. Substitutes argument symbols for bytecode flags
	# Takes two args: An argument list and function body
	pushq	ENV(%rip)
	pushq	%rbx
	pushq	32(%rsp)
	pushq	32(%rsp)
	leaq	ENV(%rip), %rax
	leaq	arg_dict_seed(%rip), %rdx
	movq	%rdx, (%rax)
	call	swap
	movq	$1, %rbx
	.subst_args_def_loop:
	call	dup # argument list
	call	car # argument
	pushq	%rbx # number
	call	define
	call	drop # nil
	call	cdr # next arg
	incq	%rbx
	movq	(%rsp), %rdi
	call	eqnil
	cmpq	$1, %rax
	jne	.subst_args_def_loop
	call	drop # nil
	call	dup # body
	jmp	.subst_args_loop
	.subst_args_skip:
	addq	$8, %rsp
	call	cdr
	.subst_args_continue:
	call	cdr
	.subst_args_loop:
	movq	(%rsp), %rdi
	call	eqnil
	cmpq	$1, %rax
	je	.subst_args_ret
	call	dup
	call	car
	cmpq	$0xa1, (%rsp)
	je	.subst_args_skip
	call	reference
	popq	%rdi
	call	eqnil
	cmpq	$1, %rax
	je	.subst_args_continue
	pushq	%rdi
	call	over
	pushq	$0xaa
	call	rplaca
	call	drop
	call	over
	call	cdr
	call	cons
	call	over
	call	swap
	call	rplacd
	call	drop
	call	cdr
	jmp	.subst_args_continue
	.subst_args_ret:
	call	drop
	popq	32(%rsp)
	popq	%rbx
	leaq	ENV(%rip), %rax
	popq	(%rax)
	popq	(%rsp)
	ret
