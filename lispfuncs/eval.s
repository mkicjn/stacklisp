.type	eval, @function #|eval|
eval:
	pushq	$0
	leaq	NIL(%rip), %rax
	pushq	%rax
	pushq	24(%rsp)
	call	lambda
	call	funcall
	popq	8(%rsp)
	ret
