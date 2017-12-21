.type	scc_copy, @function
scc_copy: # Standard calling convention copy (arg in %rdi)
	movq	%rdi, %rcx
	leaq	NIL(%rip), %rax
	cmpq	%rax, %rcx
	je	.scc_copy_nil
	cmpq	$0, %rcx
	je	.scc_copy_nil
	cmpq	$0, (%rcx)
	jz	.scc_copy_list
	movq	8(%rcx), %rdi
	movq	(%rcx), %rsi
	call	new_var
	ret
	.scc_copy_list:
	pushq	%rbx
	movq	%rcx, %rbx
	movq	8(%rbx), %rdi
	call	scc_copy
	pushq	%rax
	movq	16(%rbx), %rdi
	call	scc_copy
	pushq	%rax
	call	cons
	popq	%rax
	popq	%rbx
	.scc_copy_nil:
	ret

.type	copy, @function
copy: # Stack-based function (arg in 8(%rsp))
	movq	8(%rsp), %rdi
	call	scc_copy
	movq	%rax, 8(%rsp)
	ret
