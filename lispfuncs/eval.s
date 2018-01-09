.type	eval, @function #|eval|
eval:
	popq	%r10
	call	sspush_10
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	swap
	call	lambda	
	pushq	$0
	call	swap
	call	funcall
	call	sspop_10
	pushq	%r10
	ret
