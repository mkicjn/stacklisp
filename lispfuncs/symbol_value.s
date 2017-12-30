.type	symbol_value, @function
symbol_value: # Stack-based
	pushq	8(%rsp)
	call	global_binding
	movq	(%rsp), %rdi
	call	eqnil
	cmpq	$1, %rax
	jne	.symbol_value_g
	addq	$8, %rsp
	pushq	8(%rsp)
	call	local_binding
	.symbol_value_g:
	popq	8(%rsp)
	ret
