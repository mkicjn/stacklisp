.type	new_var, @function
new_var:
	pushq	%rdi
	pushq	%rsi
	movq	$24, %rdi
	call	malloc@plt
	popq	(%rax)	
	popq	8(%rax)
	ret

new_ivar:
	movq	$2, %rsi
	call	new_var
	ret

new_svar:
	movq	$1, %rsi
	call	new_var
	ret
