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

	leaq	teststr(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	pushq	%rax

	movq	$30, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	call	cons # (sym . 30)
	call	cons # (10 sym . 30)

	call	copy
	call	disp
	call	drop
	call	terpri

	leave
	ret
