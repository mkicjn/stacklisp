.type	decompile_var, @function #|decompile|
decompile_var:
	movq	8(%rsp), %rdi
	movq	16(%rdi), %rdi
	call	decompile
	movq	%rax, 8(%rsp)
	ret
