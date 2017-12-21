.type	terpri, @function
terpri:
	movq	$10, %rdi
	call	putchar@plt
	ret
