.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	pushq	$0
	movl	$1, %edi
	call	new_ivar
	pushq	%rax
	movl	$2, %edi
	call	new_ivar
	pushq	%rax
	movl	$3, %edi
	call	new_ivar
	pushq	%rax
	call	list
	call	disp
	call	drop
	call	terpri

	leave
	ret
