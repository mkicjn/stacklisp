.type	new_var, @function
new_var:
	pushq	%rdi
	pushq	%rsi
	movl	$24, %edi
	call	malloc@plt
	popq	(%rax)	
	popq	8(%rax)
	ret

new_ivar:
	movl	$2, %esi
	call	new_var
	ret

new_svar:
	movl	$1, %esi
	call	new_var
	ret

new_dvar:
	movl	$24, %edi
	call	malloc@plt
	movq	$4, (%rax)
	movsd	%xmm0, 16(%rax)
	ret
