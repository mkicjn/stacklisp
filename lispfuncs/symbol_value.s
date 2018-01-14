.type	symbol_value, @function #|value|
symbol_value: # Stack-based
	pushq	8(%rsp)
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	je	.symbol_value_ret
	cmpq	Tptr(%rip), %rdi
	je	.symbol_value_ret

	call	local_binding
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	jne	.symbol_value_ret
	addq	$8, %rsp
	pushq	8(%rsp)
	call	global_binding
	.symbol_value_ret:
	popq	8(%rsp)
	ret
