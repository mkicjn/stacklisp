.type	scc_rpn, @function
# Prototype. Will be updated next.
scc_rpn:
	pushq	%rbx
	movq	%rdi, %rbx
	pushq	%rbx
	call	cdr
	pushq	%rbx
	call	car
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	append
	popq	%rax
	popq	%rbx
	ret

.type	rpn, @function
rpn:
	movq	8(%rsp), %rdi
	cmpq	$0, (%rdi)
	jnz	.rpn_atom
	call	scc_rpn
	movq	%rax, 8(%rsp)
	.rpn_atom:
	ret
