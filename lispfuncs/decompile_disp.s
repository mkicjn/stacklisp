fnargs:
	.string	"%li argument(s)\n"

.type	decompile_disp, @function #|decompile|3|
decompile_disp:
	pushq	8(%rsp)
	popq	%rdi
	call	decompile
	pushq	%rax
	call	disp
	call	drop
	call	terpri
	ret
