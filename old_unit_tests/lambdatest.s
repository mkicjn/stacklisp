.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	call	dup
	call	car
	call	swap
	call	cdr
	call	car
	call	lambda
	popq	%rdi
	call	decompile
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leave
	ret
