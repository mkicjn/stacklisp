.data
seed:
	.quad	0
.text

.type	random, @function #|random|
random:
	cmpq	$0, seed(%rip)
	jnz	.random_has_seed
	xorq	%rdi, %rdi
	call	time@plt
	movq	%rax, seed(%rip)
	movq	%rax, %rdi
	call	srand@plt
	.random_has_seed:
	call	rand@plt
	movq	%rax, %rdx
	leaq	NIL(%rip), %rax
	movq	8(%rsp), %rdi
	cmpq	$2, (%rdi)
	jne	.random_ret
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	8(%rdi)
	movq	%rdx, %rdi
	movq	$2, %rsi
	call	new_var
	.random_ret:
	movq	%rax, 8(%rsp)
	ret
