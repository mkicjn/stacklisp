# not and null are synonyms
.type	not, @function
.type	null, @function
not:
null:
	leaq	NIL(%rip), %rax
	cmpq	%rax, 8(%rsp)
	jne	.null_ret
	leaq	T(%rip), %rax
	.null_ret:
	movq	%rax, 8(%rsp)
	ret
