.type	var_copy, @function
var_copy: # Standard calling convention copy (arg in %rdi)
	movq	%rdi, %rcx
	leaq	NIL(%rip), %rax
	cmpq	%rax, %rcx
	je	.var_copy_nil
	cmpq	$0, %rcx
	je	.var_copy_nil
	cmpq	$0, (%rcx)
	jz	.var_copy_list
	movq	8(%rcx), %rdi
	movq	(%rcx), %rsi
	call	new_var
	ret
	.var_copy_list:
	pushq	%rbx
	movq	%rcx, %rbx
	movq	8(%rbx), %rdi
	call	var_copy
	pushq	%rax
	movq	16(%rbx), %rdi
	call	var_copy
	pushq	%rax
	call	cons
	popq	%rax
	popq	%rbx
	.var_copy_nil:
	ret
