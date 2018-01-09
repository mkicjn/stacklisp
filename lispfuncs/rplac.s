.type	rplaca, @function #|rplaca|
rplaca: # Stack based
	movq	16(%rsp), %rdi
	cmpq	$0, (%rdi)
	jnz	.rplaca_atom
	movq	8(%rsp), %rsi
	movq	%rsi, 8(%rdi)
	.rplaca_atom:
	popq	(%rsp)
	ret

.type	rplacd, @function #|rplacd|
rplacd: # Stack based
	movq	16(%rsp), %rdi
	cmpq	$0, (%rdi)
	jnz	.rplacd_atom
	movq	8(%rsp), %rsi
	movq	%rsi, 16(%rdi)
	.rplacd_atom:
	popq	(%rsp)
	ret
