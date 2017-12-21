.type	new_var, @function
new_var:
	pushq	%rdi
	pushq	%rsi
	movq	$24, %rdi
	call	malloc@plt
	popq	(%rax)	
	popq	8(%rax)
	ret
