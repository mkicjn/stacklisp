.type	terpri, @function #|terpri|
terpri:
	movq	$'\n', %rdi
	call	putchar@plt
	popq	%rdi
	leaq	NIL(%rip), %rax
	pushq	%rax
	pushq	%rdi
	ret
