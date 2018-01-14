# Literally just prints a newline
.type	scc_terpri, @function
scc_terpri:
	movl	$'\n', %edi
	call	putchar@plt
	ret
