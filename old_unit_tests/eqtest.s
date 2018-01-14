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

	movl	$10, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	movl	$10, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
######################################
	movl	$10, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	movl	$20, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
######################################
	leaq	dbug(%rip), %rdi
	movl	$1, %esi
	call	new_var
	pushq	%rax

	leaq	dbug(%rip), %rdi
	movl	$1, %esi
	call	new_var
	pushq	%rax
######################################
	leaq	dbug(%rip), %rdi
	movl	$1, %esi
	call	new_var
	pushq	%rax

	leaq	dbug2(%rip), %rdi
	movl	$1, %esi
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
