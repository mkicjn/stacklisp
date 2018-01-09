.type	symbol_value, @function #|symbol_value|
symbol_value: # Stack-based
	pushq	8(%rsp)
	movq	(%rsp), %rdi
	leaq	NIL(%rip), %rax
	cmpq	%rax, %rdi
	je	.symbol_value_ret
	leaq	T(%rip), %rax
	cmpq	%rax, %rdi
	je	.symbol_value_ret

	call	local_binding
	movq	(%rsp), %rdi
	call	eqnil
	cmpq	$1, %rax
	jne	.symbol_value_ret
	addq	$8, %rsp
	pushq	8(%rsp)
	call	global_binding
	.symbol_value_ret:
	popq	8(%rsp)
	ret
