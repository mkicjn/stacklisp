.type	length, @function #|length|
length:
	movq	8(%rsp), %rdi
	call	scc_length
	movq	%rax, %rdi
	movq	$2, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
