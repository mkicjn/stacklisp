.type	eqnil, @function
eqnil: # Returns 1 to %rax if %rdi is NIL, 0 otherwise
	# (Only modifies %rax)
	leaq	NIL(%rip), %rax
	cmpq	%rax, %rdi
	je	.eqnil_ret1
	xorq	%rax, %rax
	ret
	.eqnil_ret1:
	movq	$1, %rax
	ret
