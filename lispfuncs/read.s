.type	lread, @function #|read|3|
lread: # Stack-oriented. Expects number of bytes to read from stdin as var on stack.
	movq	8(%rsp), %rax
	movq	8(%rax), %rdi
	call	read_bytes
	movq	%rax, 8(%rsp)
	ret
