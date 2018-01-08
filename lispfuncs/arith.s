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
	jz	.add4_ret
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

.type	mult, @function #|*|
mult:
	movq	$1, %rax
	.mul2_loop:
	cmpq	$0, 8(%rsp)
	jz	.mul2_ret
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	je	.mul2_do
	cmpq	$4, (%rdi)
	je	.mul4
	popq	(%rsp)
	jmp	.mul2_loop
	.mul2_do:
	mulq	8(%rdi)
	popq	(%rsp)
	jmp	.mul2_loop
	.mul2_ret:
	movq	%rax, %rdi
	movq	$2, %rsi
	call	new_var
	popq	%rdi
	pushq	%rax
	pushq	%rdi
	ret
	.mul4:
	cvtsi2sd %rax, %xmm0
	.mul4_loop:
	cmpq	$0, 8(%rsp)
	jz	.mul4_ret
	movq	8(%rsp), %rdi
	cmpq	$4, (%rdi)
	je	.mul4_4
	cmpq	$2, (%rdi)
	je	.mul4_2
	popq	(%rsp)
	jmp	.mul4_loop
	.mul4_2:
	cvtsi2sd 8(%rdi), %xmm1
	mulsd	%xmm1, %xmm0
	popq	(%rsp)
	jmp	.mul4_loop
	.mul4_4:
	mulsd	16(%rdi), %xmm0
	popq	(%rsp)
	jmp	.mul4_loop
	.mul4_ret:
	call	new_dvar
	popq	%rdi
	pushq	%rax
	pushq	%rdi
	ret

.type	subt, @function #|-|
subt:
	xorq	%rcx, %rcx
	.sub2_loop:
	cmpq	$0, 16(%rsp)
	jz	.sub2_ret
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	je	.sub2_do
	cmpq	$4, (%rdi)
	je	.sub4
	popq	(%rsp)
	jmp	.sub2_loop
	.sub2_do:
	addq	8(%rdi), %rcx
	popq	(%rsp)
	jmp	.sub2_loop
	.sub2_ret:
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	je	.sub2_ret_2
	cmpq	$4, (%rdi)
	je	.sub2_ret_4
	jmp	.sub4_ret_do
	.sub2_ret_4:
	cvtsi2sd %rcx, %xmm0
	subsd	16(%rdi), %xmm0
	jmp	.sub4_ret_do
	.sub2_ret_2:
	movq	8(%rdi), %rdx
	subq	%rcx, %rdx
	movq	%rdx, %rcx
	.sub2_ret_do:
	movq	%rcx, %rdi
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
	.sub4:
	cvtsi2sd %rcx, %xmm0
	.sub4_loop:
	cmpq	$0, 16(%rsp)
	jz	.sub4_ret
	movq	8(%rsp), %rdi
	cmpq	$4, (%rdi)
	je	.sub4_4
	cmpq	$2, (%rdi)
	je	.sub4_2
	popq	(%rsp)
	jmp	.sub4_loop
	.sub4_2:
	cvtsi2sd 8(%rdi), %xmm1
	addsd	%xmm1, %xmm0
	popq	(%rsp)
	jmp	.sub4_loop
	.sub4_4:
	addsd	16(%rdi), %xmm0
	popq	(%rsp)
	jmp	.sub4_loop
	.sub4_ret:
	movq	8(%rsp), %rdi
	cmpq	$4, (%rdi)
	je	.sub4_ret4
	cmpq	$2, (%rdi)
	je	.sub4_ret2
	jmp	.sub4_ret_do
	.sub4_ret2:
	movsd	%xmm0, %xmm1
	cvtsi2sd 8(%rdi), %xmm0
	subsd	%xmm1, %xmm0
	jmp	.sub4_ret_do
	.sub4_ret4:
	movq	%xmm0, %xmm1
	movsd	16(%rdi), %xmm0
	subsd	%xmm1, %xmm0
	.sub4_ret_do:
	call	new_dvar
	popq	%rdi
	pushq	%rax
	pushq	%rdi
	ret

.type	div, @function #|/|
div:
	cmpq	$0, 16(%rsp)
	jz	.div_reciprocal
	movq	$1, %rax
	.div2_loop:
	cmpq	$0, 16(%rsp)
	jz	.div2_ret
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	je	.div2_do
	cmpq	$4, (%rdi)
	je	.div4
	popq	(%rsp)
	jmp	.div2_loop
	.div2_do:
	mulq	8(%rdi)
	popq	(%rsp)
	jmp	.div2_loop
	.div2_ret:
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	je	.div2_ret2
	cmpq	$4, (%rdi)
	je	.div2_ret4
	movq	%rax, %rdi
	jmp	.div2_ret2_do
	.div2_ret2:
	movq	%rax, %rcx
	xorq	%rdx, %rdx
	movq	8(%rdi), %rax
	divq	%rcx
	cmpq	$0, %rdx
	jnz	.div2_ret_nz_mod
	movq	%rax, %rdi
	.div2_ret2_do:
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
	.div2_ret4:
	cvtsi2sd %rax, %xmm1
	movsd	16(%rdi), %xmm0
	divsd	%xmm1, %xmm0
	jmp	.div4_ret_do
	.div2_ret_nz_mod:
	cvtsi2sd %rcx, %xmm1
	cvtsi2sd 8(%rdi), %xmm0
	divsd	%xmm1, %xmm0
	jmp	.div4_ret_do
	.div4:
	cvtsi2sd %rax, %xmm0
	.div4_loop:
	cmpq	$0, 16(%rsp)
	jz	.div4_ret
	movq	8(%rsp), %rdi
	cmpq	$4, (%rdi)
	je	.div4_4
	cmpq	$2, (%rdi)
	je	.div4_2
	popq	(%rsp)
	jmp	.div4_loop
	.div4_2:
	cvtsi2sd 8(%rdi), %xmm1
	mulsd	%xmm1, %xmm0
	popq	(%rsp)
	jmp	.div4_loop
	.div4_4:
	mulsd	16(%rdi), %xmm0
	popq	(%rsp)
	jmp	.div4_loop
	.div4_ret:
	movq	8(%rsp), %rdi
	cmpq	$4, (%rdi)
	je	.div4_ret4
	cmpq	$2, (%rdi)
	je	.div4_ret2
	movq	$1, %rax
	movq	%xmm0, %xmm1
	cvtsi2sd %rax, %xmm0
	divsd	%xmm1, %xmm0
	jmp	.div4_ret_do
	.div4_ret4:
	movsd	%xmm0, %xmm1
	movsd	16(%rdi), %xmm0
	divsd	%xmm1, %xmm0
	jmp	.div4_ret_do
	.div4_ret2:
	movsd	%xmm0, %xmm1
	cvtsi2sd 8(%rdi), %xmm0
	divsd	%xmm1, %xmm0
	.div4_ret_do:
	call	new_dvar
	movq	%rax, 8(%rsp)
	ret
	.div_reciprocal:
	movq	8(%rsp), %rdi
	movq	$1, %rax
	cvtsi2sd %rax, %xmm0
	movsd	16(%rdi), %xmm1
	cmpq	$2, (%rdi)
	jne	.div_fp_reciprocal
	cmpq	$1, 8(%rdi)
	jne	.div_fp_reciprocal_not1
	movq	$1, %rdi
	jmp	.div2_ret2_do
	.div_fp_reciprocal_not1:
	cvtsi2sd 8(%rdi), %xmm1
	.div_fp_reciprocal:
	divsd	%xmm1, %xmm0
	jmp	.div4_ret_do
