.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$100, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
	call	lread
	call	prep_progn
	call	disp
	call	drop
	call	terpri

	leave
	ret
