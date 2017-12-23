.include "inclusions.s"

str:
	.string "(123 sym 456 789)"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	str(%rip), %rdi

	call	read_list
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leave
	ret
