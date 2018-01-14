.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$200, %edi
	call	read_bytes
	pushq	%rax
	call	reference
	call	disp
	call	drop
	call	terpri

	leave
	ret
