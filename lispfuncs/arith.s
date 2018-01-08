.type	add, @function #|+|
add:
	xorq	%rcx, %rcx
	.add2_loop:
	cmpq	$0, 8(%rsp)
	jz	.add2_ret
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	je	.add2_do
	cmpq	$4, (%rdi)
	je	.add4
	popq	(%rsp)
	jmp	.add2_loop
	.add2_do:
	addq	8(%rdi), %rcx
	popq	(%rsp)
	jmp	.add2_loop
	.add2_ret:
	movq	%rcx, %rdi
	movq	$2, %rsi
	call	new_var
	popq	%rdi
	pushq	%rax
	pushq	%rdi
	ret
	.add4:
	cvtsi2sd %rcx, %xmm0
	.add4_loop:
	cmpq	$0, 8(%rsp)
	je	.add4_ret
	movq	8(%rsp), %rdi
	cmpq	$4, (%rdi)
	je	.add4_4
	cmpq	$2, (%rdi)
	je	.add4_2
	popq	(%rsp)
	jmp	.add4_loop
	.add4_2:
	cvtsi2sd 8(%rdi), %xmm1
	addsd	%xmm1, %xmm0
	popq	(%rsp)
	jmp	.add4_loop
	.add4_4:
	addsd	16(%rdi), %xmm0
	popq	(%rsp)
	jmp	.add4_loop
	.add4_ret:
	call	new_dvar
	popq	%rdi
	pushq	%rax
	pushq	%rdi
	ret
