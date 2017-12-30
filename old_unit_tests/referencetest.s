.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	call	reference
	call	disp
	call	drop
	call	terpri

	leave
	ret
