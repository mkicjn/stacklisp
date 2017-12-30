.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	GLOBAL_ENV(%rip), %rdi
	pushq	%rdi
	call	disp
	call	drop
	call	terpri

	leave
	ret
