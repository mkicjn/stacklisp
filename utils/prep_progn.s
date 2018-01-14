.type	prep_progn, @function
prep_progn: # Stack-based
	pushq	$0
	pushq	16(%rsp)
	call	cdr
	.prep_progn_loop:
	call	dup
	call	car
	call	swap
	call	cdr
	pushq	$0xdd
	call	swap
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	jne	.prep_progn_loop
	popq	(%rsp) # Get rid of last $0xdd
	.prep_progn_cons_loop:
	call	cons
	cmpq	$0, 8(%rsp)
	jnz	.prep_progn_cons_loop
	popq	16(%rsp)
	addq	$8, %rsp
	ret
