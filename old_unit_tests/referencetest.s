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
	call	print
	call	drop
	call	terpri

	leave
	ret
