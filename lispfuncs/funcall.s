.type	funcall, @function
funcall: # Note: Modifies non-volatile %r14 and %r15
	pushq	%rbp
	movq	%rsp, %rbp
	movq	16(%rsp), %rax # Load the pointer to the function
	movq	$1, %rcx # Set the counter to 1 (At 0 would be # of args)
	.funcall_loop:
	movq	(%rax,%rcx,8), %rdx # Load the next address
	cmpq	$0, %rdx
	jz	.funcall_pushq
	cmpq	$1, %rdx
	je	.funcall_pusharg
	# Need to preserve function and counter -- To-do: Find a better way
	movq	%rax, %r14
	movq	%rcx, %r15
	call	*%rdx
	movq	%r15, %rcx
	movq	%r14, %rax
	incq	%rcx
	jmp	.funcall_loop
	.funcall_pushq:
	incq	%rcx
	movq	(%rax,%rcx,8), %rdx # Load the literal to be pushed
	cmpq	$0, %rdx
	jz	.funcall_exit # If null, exit (so 0x0 0x0 denotes the end of the function)
	pushq	%rdx
	incq	%rcx
	jmp	.funcall_loop
	.funcall_pusharg:
	incq	%rcx
	movq	(%rax), %rdx # -(# of args + 1)
	negq	%rdx
	subq	(%rax,%rcx,8), %rdx # Get argument offset
	addq	$2, %rdx # Skip return address and base pointer
	pushq	(%rbp,%rdx,8)
	incq	%rcx
	jmp	.funcall_loop
	.funcall_exit:
	# At this point there must only be one thing on the stack
	popq	%rdx # Take that thing off the stack
	movq	%rbp, %rsp # Reset the stack
	popq	%rbp # (see above)
	# Now the stack is the way it was when the function was called
	movq	(%rax), %rcx # Store the number of variables (plus 1)
	negq	%rcx # (see above)
	.funcall_dropargs:
	cmpq	$1, %rcx
	je	.funcall_ret
	popq	8(%rsp) # nip (drop would remove return address)
	decq	%rcx
	jmp	.funcall_dropargs
	.funcall_ret:
	movq	%rdx, 8(%rsp) # Replace final arg with return value
	ret
