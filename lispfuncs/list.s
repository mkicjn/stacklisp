.type	list, @function
list: # Stack-oriented. Expects null on stack under all args
	popq	%rdi
	call	sspush_di
	leaq	NIL(%rip), %rax
	pushq	%rax
	.list_loop:
	movq	8(%rsp), %rax
	cmpq	$0, %rax
	jz	.list_ret
	call	cons
	jmp	.list_loop
	.list_ret:
	call	sspop_di
	pushq	%rdi
	ret
