.type	terpri, @function #|terpri|
terpri:
	movl	$'\n', %edi
	call	putchar@plt
	popq	%rdi
	leaq	NIL(%rip), %rax
	pushq	%rax
	pushq	%rdi
	ret
