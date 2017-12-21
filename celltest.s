.include "inclusions.s"

iform:
	.string "%li\n"
.type	printint, @function
printint:
	leaq	iform(%rip), %rdi
	movq	8(%rsp), %rsi
	xorq	%rax, %rax
	call	printf@plt
	popq	%rdi
	movq	%rdi, (%rsp)
	ret

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	# Pretend these are addresses
	pushq	$1
	pushq	$2
	call	cons
	call	dup
	call	car
	call	printint
	call	cdr
	call	printint

	leave
	ret
