.include "inclusions.s"

teststr:
	.string "sym"

iform:
	.string "%li\n"

.type	printint, @function
printint:
	leaq	iform(%rip), %rdi
	movq	8(%rsp), %rsi
	xorq	%rax, %rax
	call	printf@plt
	call	swap
	addq	$8, %rsp
	ret

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

	leave
	ret
