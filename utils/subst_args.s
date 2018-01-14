self_op_str:
	.string	"@"
self_op_sym:
	.quad	1,self_op_str,0
self_op_ptr:
	.quad	self_op_sym

.type	subst_args, @function
subst_args: # Stack-based. Substitutes argument symbols for bytecode flags
	# Takes two args: An argument list and function body
	leaq	ENV(%rip), %rax
	leaq	NIL(%rip), %rdx
	movq	%rdx, (%rax)
	pushq	ENV(%rip)
	pushq	%rbx
	pushq	32(%rsp) # Recall args
	pushq	32(%rsp)
	call	swap # Arguments on top
	movl	$1, %ebx
	# 2 stack items (body | args) + %rbx
	.subst_args_def_loop:
	popq	%rdi
	cmpq	NILptr(%rip), %rdi
	je	.subst_args_def_self
	pushq	%rdi
	pushq	%rdi
	call	car
	pushq	%rbx
	call	define
	addq	$8, %rsp
	call	cdr
	incq	%rbx
	jmp	.subst_args_def_loop
	.subst_args_def_self:
	leaq	self_op_sym(%rip), %rax
	pushq	%rax
	pushq	%rbx
	call	define
	addq	$8, %rsp
	jmp	.subst_args_loop

	.subst_args_undef:
	addq	$8, %rsp
	call	cdr
	jmp	.subst_args_loop
	.subst_args_skip:
	addq	$8, %rsp
	call	cdr
	.subst_args_continue:
	call	cdr
	.subst_args_loop:
	# 1 stack item (body) + %rbx
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	je	.subst_args_ret
	pushq	(%rsp)
	call	car
	cmpq	$0xa1, (%rsp)
	je	.subst_args_skip
	call	local_binding
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	je	.subst_args_undef
	# The number is on the stack, body underneath
	call	over
	call	swap
	call	over
	call	cdr
	call	cons
	call	rplacd
	call	drop
	call	dup
	pushq	$0xaa
	call	rplaca
	call	drop
	call	cdr
	# The body from the next item on is top item on stack
	jmp	.subst_args_continue
	# 1 stack item (NIL) + %rbx
	.subst_args_ret:
	addq	$8, %rsp
	popq	%rbx
	popq	ENV(%rip)
	movq	8(%rsp), %rax
	movq	%rax, 16(%rsp)
	popq	(%rsp)
	ret
