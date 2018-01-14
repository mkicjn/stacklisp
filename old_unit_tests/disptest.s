.include "inclusions.s"

teststr:
	.string "sym"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$10, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	leaq	teststr(%rip), %rdi
	movl	$1, %esi
	call	new_var
	pushq	%rax

	movl	$30, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	call	cons # (sym . 30)
	call	cons # (10 sym . 30)
	call	print
	call	terpri
	call	print
	call	terpri
	call	drop

	leave
	ret
