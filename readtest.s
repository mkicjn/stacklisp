.include "inclusions.s"

str:
	.string "123 "

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	str(%rip), %rdi
	call	read_str
	movq	%rax, %rdi
	call	disp
	call	drop
	call	terpri

	leave
	ret
