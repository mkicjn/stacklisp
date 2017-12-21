.type	rpn, @function
# Prototype. Will be updated next.
rpn:
	pushq	8(%rsp) # over
	call	dup
	call	car
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	swap
	call	cdr
	call	swap
	call	cons
	popq	8(%rsp)
	ret
