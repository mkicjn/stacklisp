# Literally just prints a newline
.type	scc_terpri, @function
scc_terpri:
	movq	$'\n', %rdi
	call	putchar@plt
	ret
