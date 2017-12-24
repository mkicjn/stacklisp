.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	pushq	%rax
	call	car
	call	swap
	call	cdr
	call	car
	call	define

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	call	reference
###
/*
	movq	ENV(%rip), %rdi
	movq	(%rsp), %rsi
	call	env_assoc
	movq	16(%rax), %rax
	movq	%rax, (%rsp)
*/
###
	call	disp
	call	drop
	call	terpri

	leave
	ret
