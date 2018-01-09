# not and null are synonyms
.type	not, @function #|not|
.type	null, @function #|null|
not:
null:
	leaq	NIL(%rip), %rax
	cmpq	%rax, 8(%rsp)
	jne	.null_ret
	leaq	T(%rip), %rax
	.null_ret:
	movq	%rax, 8(%rsp)
	ret
