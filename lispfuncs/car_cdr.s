# These functions are guaranteed to preserve all registers except %rax

.type	car, @function
car:
	movq	8(%rsp), %rax
	cmpq	$0, (%rax)
	jnz	.nil_ret
	movq	8(%rax), %rax
	movq	%rax, 8(%rsp)
	ret

.type	cdr, @function
cdr:
	movq	8(%rsp), %rax
	cmp	$0, (%rax)
	jnz	.nil_ret
	movq	16(%rax), %rax
	movq	%rax, 8(%rsp)
	ret

.nil_ret:
	leaq	NIL(%rip), %rax
	movq	%rax, 8(%rsp)
	ret
