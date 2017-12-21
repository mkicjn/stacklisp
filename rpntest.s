.include "inclusions.s"

teststr:
	.string	"+"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	teststr(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	pushq	%rax

	movq	$1, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	movq	$2, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	leaq	NIL(%rip), %rax
	pushq	%rax

	call	cons
	call	cons
	call	cons
	call	dup
	call	disp
	call	drop
	call	terpri
	call	rpn
	call	disp
	call	drop
	call	terpri

	leave
	ret
