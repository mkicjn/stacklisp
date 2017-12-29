.type	funcall, @function
funcall: # Stack-based. This is the bytecode interpreter.
	pushq	%rax
	pushq	%rcx
	pushq	%rbp
	movq	%rsp, %rbp
	movq	32(%rsp), %rax # Load pointer to function (past return addr/backups)
	movq	$1, %rcx # Set the counter to 1 (At 0 would be # of args)
	.funcall_loop:
	movq	(%rax,%rcx,8), %rdx # Load the next instruction
	cmpq	$0xa1, %rdx
	jz	.funcall_pushq
	cmpq	$0xaa, %rdx
	je	.funcall_pusharg
	cmpq	$0xc0, %rdx
	je	.funcall_cond
	cmpq	$0xc1, %rdx
	je	.funcall_case
	cmpq	$0xc2, %rdx
	je	.funcall_case_exit
	cmpq	$0xc3, %rdx
	je	.funcall_cond_exit
	cmpq	$0xca, %rdx
	je	.funcall_call
	cmpq	$0xdd, %rdx
	je	.funcall_drop
	cmpq	$0xee, %rdx
	je	.funcall_exit
	# It is assumed at this point that the instruction must be a variable to be referenced
	pushq	%rdx
	cmpq	$1, (%rdx)
	jne	.funcall_no_ref # If not a symbol, push to stack as-is.
	call	sspush_a_c
	call	reference
	call	sspop_a_c
	popq	%rdx
	cmpq	$3, (%rdx)
	jge	.funcall_call_do
	cmpq	$0, (%rdx)
	jl	.funcall_call_do
	pushq	%rdx
	.funcall_no_ref:
	incq	%rcx
	jmp	.funcall_loop
	.funcall_asmcall:
	# Need to preserve function and counter.
	# The new solution for this is good, but unnecessary unless a core function calls funcall
	# As a result, this might change in the future.
	call	sspush_a_c
	call	*%rdx
	call	sspop_a_c
	incq	%rcx
	jmp	.funcall_loop
	.funcall_pushq:
	incq	%rcx
	movq	(%rax,%rcx,8), %rdx # Load the literal to be pushed
	pushq	%rdx
	incq	%rcx
	jmp	.funcall_loop
	.funcall_pusharg:
	incq	%rcx
	movq	(%rax), %rdx # -(# of args + 1)
	negq	%rdx
	subq	(%rax,%rcx,8), %rdx # Get argument offset
	addq	$4, %rdx # Skip return address, base pointer, and rax/rcx backups
	pushq	(%rbp,%rdx,8)
	incq	%rcx
	jmp	.funcall_loop
	.funcall_call:
	incq	%rcx
	movq	(%rax,%rcx,8), %rdx # Load the function to be called
	cmpq	$1, (%rdx)
	jne	.funcall_call_do
	pushq	%rdx
	call	sspush_a_c
	call	reference
	call	sspop_a_c
	popq	%rdx
	.funcall_call_do:
	cmpq	$3, (%rdx)
	jge	.funcall_asmfunc
	pushq	%rdx
	call	funcall
	incq	%rcx
	jmp	.funcall_loop
	.funcall_asmfunc:
	movq	8(%rdx), %rdx
	jmp	.funcall_asmcall

	.funcall_cond:
	.funcall_cond_exit:
	incq	%rcx
	jmp	.funcall_loop

	.funcall_case:
	popq	%rdi # Check the top stack item as a condition
	pushq	%rax # Back up the function
	call	eqnil
	movq	%rax, %rdx
	incq	%rcx # Go to next instruction
	popq	%rax # Recall function
	cmpq	$1, %rdx
	jne	.funcall_loop # If the condition isn't nil, execute
	decq	%rcx # decq to incq at start of loop
	movq	$1, %rdi # Start with 1 for current present case
	.funcall_case_skip: # Keep skipping instructions until {CASE_END}
	incq	%rcx # Go to next instruction
	movq	(%rax,%rcx,8), %rdx # Load instruction
	cmpq	$0xc1, %rdx
	je	.funcall_case_skip_c1 # Increment %rdi and continue looping
	cmpq	$0xc2, %rdx
	je	.funcall_case_skip_c2 # Decrement %rdi, exit if 0
	jmp	.funcall_case_skip
	.funcall_case_skip_c1:
	incq	%rdi
	jmp	.funcall_case_skip
	.funcall_case_skip_c2:
	decq	%rdi
	cmpq	$0, %rdi
	jnz	.funcall_case_skip
	incq	%rcx
	jmp	.funcall_loop

	.funcall_case_exit:
	movq	$1, %rdi
	.funcall_case_exit_skip:
	incq	%rcx
	movq	(%rax,%rcx,8), %rdx
	cmpq	$0xc0, %rdx
	je	.funcall_case_exit_c0
	cmpq	$0xc3, %rdx
	je	.funcall_case_exit_c3
	jmp	.funcall_case_exit_skip
	.funcall_case_exit_c0:
	incq	%rdi
	jmp	.funcall_case_exit_skip
	.funcall_case_exit_c3:
	decq	%rdi
	cmpq	$0, %rdi
	jnz	.funcall_case_exit_skip
	incq	%rcx
	jmp	.funcall_loop

	.funcall_drop:
	addq	$8, %rsp
	jmp	.funcall_loop
	
	.funcall_exit:
	# At this point there must only be one thing on the stack
	popq	%rdi # Take that thing off the stack
	# Now the stack should be the way it was before .funcall_loop
	movq	%rbp, %rsp # Reset the stack
	popq	%rbp # (see above)
	movq	8(%rsp), %rax # Recall function
	movq	(%rax), %rdx # Store the number of variables
	negq	%rdx # (see above)
	decq	%rdx # (see above)
	movq	$8, %rax
	mulq	%rdx
	movq	%rax, %rdx  # Store number of bytes worth of variables
	popq	%rcx # Pick up backed up registers
	popq	%rax # (see above)
	popq	%rsi # Preserve return address
	addq	%rdx, %rsp
	pushq	%rdi
	pushq	%rsi
	ret
	.funcall_ret:
	movq	%rdx, 8(%rsp) # Replace final arg with return value
	ret
