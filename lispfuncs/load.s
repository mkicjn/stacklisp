.type	load, @function
load:
	movq	8(%rsp), %rdi
	movq	8(%rdi), %rdi
	call	read_file
	pushq	%rax
	call	eval
	popq	8(%rsp)
	ret
