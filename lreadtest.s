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
	call	rpn
	call	disp
	call	drop
	call	terpri

	leave
	ret
