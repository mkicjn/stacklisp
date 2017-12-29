.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$100, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax
	call	lread
	call	dup
	call	disp
	call	drop
	call	terpri
	call	rpn
	call	dup
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
