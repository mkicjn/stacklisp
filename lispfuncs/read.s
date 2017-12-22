.type	infer_type, @function
infer_type:
	xorq	%rcx, %rcx
	cmpb	$40, (%rdi)
	je	.infer_type0
	.infer_type_loop:
	cmpb	$0, (%rdi)
	jz	.infer_type2
	cmpb	$48, (%rdi)
	jnge	.infer_type1
	cmpb	$57, (%rdi)
	jnle	.infer_type1
	incq	%rdi
	jmp	.infer_type_loop
	.infer_type2:
	movq	$2, %rax
	ret
	.infer_type1:
	movq	$1, %rax
	ret
	.infer_type0:
	cmpb	$40, (%rdi)
	je	.infer_type0_lp
	cmpb	$41, (%rdi)
	je	.infer_type0_rp
	cmpb	$0, (%rdi)
	jz	.infer_type0_ret
	incq	%rdi
	jmp	.infer_type0
	.infer_type0_lp:
	incq	%rcx
	incq	%rdi
	jmp	.infer_type0
	.infer_type0_rp:
	decq	%rcx
	incq	%rdi
	jmp	.infer_type0
	.infer_type0_ret:
	cmpq	$0, %rcx
	jnz	.infer_type_error
	xorq	%rax, %rax
	ret
	.infer_type_error:
	movq	$-1, %rax
	ret
