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
	pushq	%rax
	call	car
	call	swap
	call	cdr
	call	car

	leaq	ENV(%rip), %rdi
	popq	%rdx
	popq	%rsi
	call	env_def

	movq	ENV(%rip), %rax
	pushq	%rax
	call	print
	call	drop
	call	terpri

	call	car
	popq	%rsi
	movq	ENV(%rip), %rdi
	call	env_assoc
	pushq	%rax
	call	cdr
	call	print
	call	drop
	call	terpri

	leave
	ret
