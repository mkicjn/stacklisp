.type	list, @function #|list|
list: # Stack-oriented; Variadic
	leaq	NIL(%rip), %rax
	.list_loop:
	cmpq	$0, 8(%rsp)
	jz	.list_ret
	pushq	8(%rsp)
	pushq	%rax
	call	cons
	popq	%rax
	popq	(%rsp)
	jmp	.list_loop
	.list_ret:
	pushq	%rax
	call	swap
	ret
