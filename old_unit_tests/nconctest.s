.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$1, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
	movl	$2, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	cons
	call	dup
	call	print
	call	drop
	call	terpri
	movl	$3, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
	movl	$4, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	cons
	call	dup
	call	print
	call	drop
	call	terpri
	call	nconc
	call	dup
	call	print
	call	drop
	call	terpri

	leave
	ret
