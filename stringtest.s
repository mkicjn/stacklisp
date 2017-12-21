.include "inclusions.s"

.test:
	.string "test"

.meme:
	.string "meme"

.global	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsi, %rbp

	movq	$100, %rdi
	call	malloc@plt
	pushq	%rax
	movq	$0, %rdi
	movq	%rax, %rsi
	movq	$99, %rdx
	call	read@plt
	movq	%rsi, %rdi
	chain	chomp
	chain	toupper
	call	puts@plt
	popq	%rdi
	call	free@plt
	popq	%rbp
	xorq	%rax, %rax
	ret
