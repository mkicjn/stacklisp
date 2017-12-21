.include "inclusions.s"

teststr:
	.string "sym"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$10, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	movq	$20, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	leaq	teststr(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	pushq	%rax

	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	cons # (20 sym)

	movq	$30, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	leaq	NIL(%rip), %rax
	pushq	%rax

	call	cons
	call	cons
	call	cons # (10 (20 sym) 30)
	call	dup
	call	disp
	call	drop
	call	terpri
	call	lambda_size
	call	printint
	call	drop

	leave
	ret
