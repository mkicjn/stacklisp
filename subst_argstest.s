.include "inclusions.s"

argstr:
	.string	"(x y z)"
bodystr:
	.string	"(+ (- x y) z)"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

#	leaq	argstr(%rip), %rdi
#	call	to_var
	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	call	dup
	call	disp
	call	drop

#	leaq	bodystr(%rip), %rdi
#	call	to_var
	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	call	dup
	call	disp
	call	drop
	call	terpri

	call	rpn
	call	subst_args
	call	dup
	call	disp
	call	drop
	call	terpri

	popq	%rdi
	call	lambda_size
	pushq	%rax
	call	printint
	call	drop
	call	terpri

	leave
	ret
