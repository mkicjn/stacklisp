.data
seed:
	.quad	0
.text

.type	seed_rng, @function
seed_rng:
	movq	$0xd, %rdi
	xorq	%rsi, %rsi
	call	syscall@plt
	movq	%rax, seed(%rip)
	ret
