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
	movl	$2, %esi
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
	movl	$1, %eax
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
	movl	$2, %esi
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
	movl	$2, %esi
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
	movl	$1, %eax
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
	movl	$2, %esi
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
	movl	$1, %eax
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
	movl	$1, %eax
	cvtsi2sd %rax, %xmm0
	movsd	16(%rdi), %xmm1
	cmpq	$2, (%rdi)
	jne	.div_fp_reciprocal
	cmpq	$1, 8(%rdi)
	jne	.div_fp_reciprocal_not1
	movl	$1, %edi
	jmp	.div2_ret2_do
	.div_fp_reciprocal_not1:
	cvtsi2sd 8(%rdi), %xmm1
	.div_fp_reciprocal:
	divsd	%xmm1, %xmm0
	jmp	.div4_ret_do

.type	greater_than, @function #|>|
greater_than:
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.greater_than_2
	cmpq	$4, (%rax)
	je	.greater_than_4
	.greater_than_2:
	cvtsi2sd 8(%rax), %xmm0
	jmp	.greater_than_loop
	.greater_than_4:
	movsd	16(%rax), %xmm0
	.greater_than_loop:
	cmpq	$0, 8(%rsp)
	jz	.greater_than_ret_t
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.greater_than_loop_2
	cmpq	$4, (%rax)
	je	.greater_than_loop_4
	popq	(%rsp)
	jmp	.greater_than_loop
	.greater_than_loop_2:
	cvtsi2sd 8(%rax), %xmm1
	jmp	.greater_than_loop_comp
	.greater_than_loop_4:
	movsd	16(%rax), %xmm1
	.greater_than_loop_comp:
	comisd	%xmm1, %xmm0
	jnbe	.greater_than_nil
	popq	(%rsp)
	movsd	%xmm1, %xmm0
	jmp	.greater_than_loop
	.greater_than_nil:
	cmpq	$0, 8(%rsp)
	jz	.greater_than_ret_nil
	popq	(%rsp)
	jmp	.greater_than_nil
	.greater_than_ret_nil:
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	swap
	ret
	.greater_than_ret_t:
	leaq	T(%rip), %rax
	pushq	%rax
	call	swap
	ret

.type	less_than, @function #|<|
less_than:
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.less_than_2
	cmpq	$4, (%rax)
	je	.less_than_4
	.less_than_2:
	cvtsi2sd 8(%rax), %xmm0
	jmp	.less_than_loop
	.less_than_4:
	movsd	16(%rax), %xmm0
	.less_than_loop:
	cmpq	$0, 8(%rsp)
	jz	.less_than_ret_t
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.less_than_loop_2
	cmpq	$4, (%rax)
	je	.less_than_loop_4
	popq	(%rsp)
	jmp	.less_than_loop
	.less_than_loop_2:
	cvtsi2sd 8(%rax), %xmm1
	jmp	.less_than_loop_comp
	.less_than_loop_4:
	movsd	16(%rax), %xmm1
	.less_than_loop_comp:
	comisd	%xmm1, %xmm0
	jnae	.less_than_nil
	popq	(%rsp)
	movsd	%xmm1, %xmm0
	jmp	.less_than_loop
	.less_than_nil:
	cmpq	$0, 8(%rsp)
	jz	.less_than_ret_nil
	popq	(%rsp)
	jmp	.less_than_nil
	.less_than_ret_nil:
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	swap
	ret
	.less_than_ret_t:
	leaq	T(%rip), %rax
	pushq	%rax
	call	swap
	ret

.type	n_equal, @function #|=|
n_equal:
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.n_equal_2
	cmpq	$4, (%rax)
	je	.n_equal_4
	.n_equal_2:
	cvtsi2sd 8(%rax), %xmm0
	jmp	.n_equal_loop
	.n_equal_4:
	movsd	16(%rax), %xmm0
	.n_equal_loop:
	cmpq	$0, 8(%rsp)
	jz	.n_equal_ret_t
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.n_equal_loop_2
	cmpq	$4, (%rax)
	je	.n_equal_loop_4
	popq	(%rsp)
	jmp	.n_equal_loop
	.n_equal_loop_2:
	cvtsi2sd 8(%rax), %xmm1
	jmp	.n_equal_loop_comp
	.n_equal_loop_4:
	movsd	16(%rax), %xmm1
	.n_equal_loop_comp:
	comisd	%xmm1, %xmm0
	jne	.n_equal_nil
	popq	(%rsp)
	movsd	%xmm1, %xmm0
	jmp	.n_equal_loop
	.n_equal_nil:
	cmpq	$0, 8(%rsp)
	jz	.n_equal_ret_nil
	popq	(%rsp)
	jmp	.n_equal_nil
	.n_equal_ret_nil:
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	swap
	ret
	.n_equal_ret_t:
	leaq	T(%rip), %rax
	pushq	%rax
	call	swap
	ret

.type	mod, @function #|mod|
mod:
	movq	16(%rsp), %rax
	movq	8(%rsp), %rcx
	cmpq	$2, (%rax)
	je	.mod_2__
	cmpq	$4, (%rax)
	je	.mod_4__
	leaq	NIL(%rip), %rax
	jmp	.mod_ret
	.mod_2__:
	movq	8(%rax), %rax
	cmpq	$2, (%rcx)
	je	.mod_2
	cmpq	$4, (%rcx)
	je	.mod_2_4
	leaq	NIL(%rip), %rax
	jmp	.mod_ret
	.mod_4__:
	movsd	16(%rax), %xmm0
	cmpq	$4, (%rcx)
	je	.mod_4_4
	cmpq	$2, (%rcx)
	je	.mod_4_2
	leaq	NIL(%rip), %rax
	jmp	.mod_ret
	.mod_2:
	xorq	%rdx, %rdx
	divq	8(%rcx)
	movq	%rdx, %rdi
	movl	$2, %esi
	call	new_var
	jmp	.mod_ret
	.mod_2_4:
	cvtsi2sd %rax, %xmm0
	movsd	16(%rcx), %xmm1
	jmp	.mod4
	.mod_4_4:
	movsd	16(%rcx), %xmm1
	jmp	.mod4
	.mod_4_2:
	cvtsi2sd 16(%rcx), %xmm1
	.mod4:
	call	fmod@plt
	call	new_dvar
	.mod_ret:
	popq	(%rsp)
	movq	%rax, 8(%rsp)
	ret

.type	lfloor, @function #|floor|
lfloor:
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.lfloor_ret
	cmpq	$4, (%rax)
	jne	.lfloor_ret_nil
	movsd	16(%rax), %xmm0
	roundsd	$9, %xmm0, %xmm0
	cvttsd2si %xmm0, %rdi
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
	.lfloor_ret_nil:
	leaq	NIL(%rip), %rax
	movq	%rax, 8(%rsp)
	.lfloor_ret:
	ret

.type	ceiling, @function #|ceiling|
ceiling:
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	je	.ceiling_ret
	cmpq	$4, (%rax)
	jne	.ceiling_ret_nil
	movsd	16(%rax), %xmm0
	roundsd	$10, %xmm0, %xmm0
	cvttsd2si %xmm0, %rdi
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
	.ceiling_ret_nil:
	leaq	NIL(%rip), %rax
	movq	%rax, 8(%rsp)
	.ceiling_ret:
	ret

.type	expt, @function #|^|
expt:
	xorq	%rcx, %rcx
	#.expt_0: # Check the first argument
	movq	16(%rsp), %rax
	cmpq	$2, (%rax)
	jne	.expt_1
	cvtsi2sd 8(%rax), %xmm0
	cmpq	$0, 8(%rax)
	jl	.expt_2
	incq	%rcx
	jmp	.expt_2
	.expt_1: # First arg could be a double
	cmpq	$4, (%rax)
	jne	.expt_ret_nil
	movsd	16(%rax), %xmm0
	.expt_2: # Check the second argument
	movq	8(%rsp), %rax
	cmpq	$2, (%rax)
	jne	.expt_3
	cvtsi2sd 8(%rax), %xmm1
	cmpq	$0, 8(%rax)
	jl	.expt_4
	incq	%rcx
	jmp	.expt_4
	.expt_3: # Second arg could be a double
	cmpq	$4, (%rax)
	jne	.expt_ret_nil
	movsd	16(%rax), %xmm1
	.expt_4:
	pushq	%rcx
	movl	%esp, %edx
	andl	$15, %edx
	testb	%dl, %dl
	jz	.expt_aligned
	subq	$8, %rsp
	call	pow@plt
	addq	$8, %rsp
	jmp	.expt_do
	.expt_aligned:
	call	pow@plt
	.expt_do:
	popq	%rcx
	cmpq	$2, %rcx
	jne	.expt_ret4
	#.expt_ret2: # Answer is an integer
	cvttsd2si %xmm0, %rdi
	movq	$2, %rsi
	call	new_var
	popq	(%rsp)
	movq	%rax, 8(%rsp)
	ret
	.expt_ret4:
	call	new_dvar
	popq	(%rsp)
	movq	%rax, 8(%rsp)
	ret
	.expt_ret_nil:
	leaq	NIL(%rip), %rax
	popq	(%rsp)
	movq	%rax, 8(%rsp)
	ret
