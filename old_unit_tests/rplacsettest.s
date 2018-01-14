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

	movl	$3, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	call	rplaca

	movl	$4, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	call	rplacd

	call	dup
	call	disp
	call	drop
	call	terpri

	movl	$5, %edi
	movl	$2, %esi
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
