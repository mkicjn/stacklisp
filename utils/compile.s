.type	compile, @function
compile: # Standard calling convention. Places every pointer in a list at %rsi into a memory block at %rdi and appends 0xee and 0xfe
	pushq	%rdi
	pushq	%rbx
	movq	%rdi, %rbx
	xorq	%rcx, %rcx
	pushq	%rsi
	.compile_loop:
	call	dup
	call	car
	popq	(%rbx)
	addq	$8, %rbx
	call	cdr
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	jne	.compile_loop
	movq	$0xee, (%rbx)
	movq	$0xfe, 8(%rbx)
	addq	$8, %rsp
	popq	%rbx
	popq	%rax
	ret # Return block

.type	decompile, @function
decompile: # Standard calling convention. Places every pointer in a block of memory at %rdi until 0xfe into a list at %rax
	pushq	$0xfe
	.decompile_loop:
	pushq	(%rdi)
	addq	$8, %rdi
	cmpq	$0xfe, (%rdi)
	jne	.decompile_loop
	leaq	NIL(%rip), %rax
	pushq	%rax
	.decompile_cons_loop:
	call	cons
	cmpq	$0xfe, 8(%rsp)
	jnz	.decompile_cons_loop
	popq	%rax
	addq	$8, %rsp
	ret
