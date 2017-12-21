.type	append, @function
append:
	pushq	16(%rsp)
	call	copy
	#debug_disp
	pushq	16(%rsp)
	call	nconc
	popq	%rax
	popq	(%rsp)
	movq	%rax, 8(%rsp)
	ret
