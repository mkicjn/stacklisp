.include "inclusions.s"

argstr:
	.string	"(x y z)"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$0x06281999, %rbx

	leaq	argstr(%rip), %rdi
	call	to_var
	pushq	%rax

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax

	call	rpn
	call	subst_args
	ddt

	leave
	ret
