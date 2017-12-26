.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	pushq	$0
	movq	$1, %rdi
	call	new_ivar
	pushq	%rax
	movq	$2, %rdi
	call	new_ivar
	pushq	%rax
	movq	$3, %rdi
	call	new_ivar
	pushq	%rax
	call	list
	call	disp
	call	drop
	call	terpri

	leave
	ret
