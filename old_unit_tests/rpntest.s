.include "inclusions.s"

argstr:
	.string	"(x y z)"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	argstr(%rip), %rdi
	call	to_var
	pushq	%rax

	movl	$200, %edi
	call	read_bytes
	pushq	%rax
	dddt

	call	rpn
	call	subst_args
	ddt

	leave
	ret
