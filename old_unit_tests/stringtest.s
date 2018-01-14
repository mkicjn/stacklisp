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

	movl	$100, %edi
	call	malloc@plt
	pushq	%rax
	movl	$0, %edi
	movq	%rax, %rsi
	movl	$99, %edx
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
