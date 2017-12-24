.include "inclusions.s"

str:
	.string "(1 (2 test 3) 4)"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	str(%rip), %rdi

	call	read_str
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leave
	ret
