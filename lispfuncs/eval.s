.type	eval, @function
eval:
	popq	%r10
	call	sspush_10
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	swap
	call	lambda	
	call	funcall
	call	sspop_10
	pushq	%r10
	ret
