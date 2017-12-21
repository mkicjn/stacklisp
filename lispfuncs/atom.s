.type	atom, @function
atom:
	popq	%rdi
	popq	%rax
	cmpq	$0, (%rax)
	leaq	NIL(%rip), %rax
	jz	.atom_ret
	leaq	T(%rip), %rax
.atom_ret:
	pushq	%rax
	pushq	%rdi
	ret
