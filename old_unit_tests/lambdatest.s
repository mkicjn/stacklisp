.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	dddt
	call	dup
	call	car
	call	swap
	call	cdr
	call	car
	call	lambda
	popq	%rdi
	movq	16(%rdi), %rdi
	call	decompile
	pushq	%rax
	ddt

	leave
	ret

