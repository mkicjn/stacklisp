.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

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

	movq	$3, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	call	rplaca

	movq	$4, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	call	rplacd

	call	dup
	call	disp
	call	drop
	call	terpri

	movq	$5, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons

	call	set

	call	disp
	call	drop
	call	terpri

	leave
	ret
