.include "inclusions.s"

teststr:
	.string "(a b)"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	teststr(%rip), %rdi
	call	read_list
	pushq	%rax
	pushq	%rax
	call	car
	call	swap
	call	cdr
	call	car

	leaq	GLOBAL_ENV(%rip), %rdi
	popq	%rdx
	popq	%rsi
	pushq	%rdi
	call	env_def
	call	disp
	call	drop
	call	terpri

	leave
	ret
