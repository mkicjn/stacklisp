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
#####
#	call	lambda
#/*
	movq	8(%rsp), %rdi
	call	scc_length
	negq	%rax
	decq	%rax
	pushq	%rax
	pushq	16(%rsp) # Arguments
	pushq	16(%rsp) # Body
	call	rpn
	dddt
	call	subst_args
	dddt
	movq	(%rsp), %rdi
	call	scc_length
	leaq	24(,%rax,8), %rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rsi
	popq	(%rdi)
	call	compile
	popq	(%rsp) # Drop second argument
	movq	%rax, (%rsp) # Replace first
#*/
#######
	popq	%rdi
	call	decompile
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leave
	ret

