.type	add, @function #|+|4|
add:
	xorq	%r8, %r8
	.add_loop:
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	jne	.add_skip
	addq	8(%rdi), %r8
	.add_skip:
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
	cmpq	$2, (%rdi)
	jne	.subt_add_skip
	addq	8(%rdi), %r8
	.subt_add_skip:
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

.type	mult, @function #|*|4|
mult:
	movq	$1, %rax
	.mult_loop:
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	jne	.mult_skip
	mulq	8(%rdi)
	.mult_skip:
	popq	(%rsp)
	cmpq	$0, 8(%rsp)
	jne	.mult_loop
	.mult_ret:
	movq	%rax, %rdi
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
