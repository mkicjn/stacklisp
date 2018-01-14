.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$0, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
	call	type
	call	print
	call	drop
	call	terpri

	leave
	ret
