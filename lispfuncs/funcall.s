.type	funcall, @function #|funcall|
funcall: # Stack-based. This is the bytecode interpreter.
	pushq	%rax
	pushq	%rcx
	pushq	ENV(%rip)
	pushq	%rbp
	movq	%rsp, %rbp
	movq	40(%rsp), %rax # Load pointer to function var (past return addr/bp)
	movq	8(%rax), %rcx
	movq	%rcx, ENV(%rip) # Reload environment from function's creation
	movq	16(%rax), %rax # Load pointer to function block
	xorq	%rcx, %rcx # Set the counter to the function's beginning
	.funcall_loop:
	movq	(%rax,%rcx,8), %rdx # Load the next instruction
	cmpq	$0, %rdx
	jz	.funcall_null
	cmpq	$0xa1, %rdx
	je	.funcall_pushq
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
	cmpq	$0xff, %rdx
	jle	.funcall_no_ref # If a flag, push as-is
	cmpq	$1, (%rdx)
	jne	.funcall_no_ref # If not a symbol, push to stack as-is.
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	call	symbol_value
	popq	16(%rsp)
	popq	%rcx
	popq	%rax
	.funcall_no_ref:
	incq	%rcx
	jmp	.funcall_loop
	.funcall_asmcall:
	# Need to preserve function and counter.
	call	sspush_a_c
	call	*%rdx
	call	sspop_a_c
	popq	(%rsp)
	incq	%rcx
	jmp	.funcall_loop
	.funcall_pushq:
	incq	%rcx
	movq	(%rax,%rcx,8), %rdx # Load the literal to be pushed
	pushq	%rdx
	incq	%rcx
	jmp	.funcall_loop
	.funcall_null:
	pushq	$0
	incq	%rcx
	jmp	.funcall_loop

	.funcall_pusharg:
	incq	%rcx
	movq	40(%rbp), %rdx # Recall function
	movq	(%rdx), %rdx # -(# of args + 1)
	negq	%rdx
	subq	(%rax,%rcx,8), %rdx # Get argument offset
	pushq	40(%rbp,%rdx,8) # Skip return address and backups
	incq	%rcx
	jmp	.funcall_loop

	.funcall_call:
	popq	%rdx # Load the function to be called
	cmpq	$0xff, %rdx
	jle	.funcall_call_skip # Don't call flags
	cmpq	$1, (%rdx)
	jne	.funcall_call_do # (i.e. don't get binding unless symbol)
	pushq	$0
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	call	symbol_value
	popq	16(%rsp)
	popq	%rcx
	popq	%rax
	.funcall_call_do:
	cmpq	$3, (%rdx)
	jge	.funcall_asmfunc
	pushq	%rdx
	call	funcall
	.funcall_call_skip:
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
	incq	%rcx
	jmp	.funcall_loop
	
	.funcall_exit:
	# At this point there must only be one thing on the stack
	popq	%rdi # Take that thing off the stack
	# Now the stack should be the way it was before .funcall_loop
	movq	%rbp, %rsp # Reset the stack
	popq	%rbp # (see above)
	popq	ENV(%rip)
	popq	%rcx
	popq	%rax
	movq	8(%rsp), %rdx # Recall function
	movq	(%rdx), %rdx # Store the number of variables
	negq	%rdx # (see above)
	decq	%rdx # (see above)
	leaq	16(,%rdx,8), %rdx # Store number of bytes worth of arguments (+ function)
	popq	%rsi # Preserve return address
	addq	%rdx, %rsp # Destroy variables
	pushq	%rdi
	pushq	%rsi
	ret
