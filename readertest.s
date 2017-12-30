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
	call	car
	call	swap
	call	cdr
	call	car
	dddt
	call	rpn
	dddt
	call	subst_args
	dddt
	call	drop

	leave
	ret
