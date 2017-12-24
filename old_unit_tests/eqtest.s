.include "inclusions.s"

dbug:
	.string "debug"
dbug2:
	.string "debug2"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$10, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	movq	$10, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax
######################################
	movq	$10, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax

	movq	$20, %rdi
	movq	$2, %rsi
	call	new_var
	pushq	%rax
######################################
	leaq	dbug(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	pushq	%rax

	leaq	dbug(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	pushq	%rax
######################################
	leaq	dbug(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	pushq	%rax

	leaq	dbug2(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	pushq	%rax
######################################
	call	eq
	call	disp # NIL
	call	drop
	call	terpri
	call	eq
	call	disp # T
	call	drop
	call	terpri
	call	eq
	call	disp # NIL
	call	drop
	call	terpri
	call	eq
	call	disp # T
	call	drop
	call	terpri

	leave
	ret
