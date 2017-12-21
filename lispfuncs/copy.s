.type	scc_copy, @function
scc_copy: # Standard calling convention copy (arg in %rdi)
	movq	%rdi, %rax
	cmpq	$0, (%rax)
	jz	.scc_copy_list
	movq	8(%rax), %rdi
	movq	(%rax), %rsi
	call	new_var
	ret
	.scc_copy_list:
	pushq	%rbx
	movq	%rax, %rbx
	movq	8(%rbx), %rdi
	call	scc_copy
	pushq	%rax
	movq	16(%rbx), %rdi
	call	scc_copy
	pushq	%rax
	call	cons
	popq	%rax
	popq	%rbx
	ret

.type	copy, @function
copy: # Stack-based function (arg in 8(%rsp))
	movq	8(%rsp), %rdi
	call	scc_copy
	movq	%rax, 8(%rsp)
	ret
