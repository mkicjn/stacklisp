.include "inclusions.s"

str:
	.string "testfile.lisp"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	str(%rip), %rdi
	call	read_file
	pushq	%rax
	ddt

	leave
	ret
