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
	call	rpn
	call	disp
	call	drop
	call	terpri
	popq	%rdi
	call	lambda_size
	pushq	%rax
	call	printint
	call	drop

	leave
	ret
