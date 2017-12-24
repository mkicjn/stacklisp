.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$0, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax
	call	type
	call	disp
	call	drop
	call	terpri

	leave
	ret
