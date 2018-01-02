fshex:
	.string	"0x%X "

.type	decompile_disp, @function #|decompile|3|
decompile_disp:
	leaq	fshex(%rip), %rdi
	movq	8(%rsp), %rsi
	movq	(%rsi), %rsi
	xorq	%rax, %rax
	call	printf@plt
	movq	8(%rsp), %rdi
	call	decompile
	pushq	%rax
	call	disp
	call	drop
	call	terpri
	ret
