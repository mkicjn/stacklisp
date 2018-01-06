.type	add, @function #|+|4|
add:
	xorq	%r8, %r8
	.add_loop:
	movq	8(%rsp), %rdi
	cmpq	$0xff, %rdi
	jle	.add_loop
	cmpq	$2, (%rdi)
	jne	.add_loop
	addq	8(%rdi), %r8
	popq	(%rsp)
	cmpq	$0, 8(%rsp)
	jne	.add_loop
	movq	%r8, %rdi
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret

.type	subt, @function #|-|4|
subt: # n1-n2-n3-...-ni = n1-(n2+n3+...+ni)
	xorq	%r8, %r8
	cmpq	$0, 16(%rsp)
	je	.subt_neg
	.subt_add_loop:
	movq	8(%rsp), %rdi
	cmpq	$0xff, %rdi
	jle	.subt_add_loop
	cmpq	$2, (%rdi)
	jne	.subt_add_loop
	addq	8(%rdi), %r8
	popq	(%rsp)
	cmpq	$0, 16(%rsp)
	jne	.subt_add_loop
	movq	8(%rsp), %rdi
	movq	8(%rdi), %rdi
	subq	%r8, %rdi
	.subt_ret:
	movq	$2, %rsi
	call	new_var
	popq	(%rsp)
	movq	%rax, 8(%rsp)
	ret
	.subt_neg:
	movq	8(%rsp), %rdi
	movq	8(%rdi), %rdi
	negq	%rdi
	jmp	.subt_ret
