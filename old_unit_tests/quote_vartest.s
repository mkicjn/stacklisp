.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$200, %rdi
	call	read_bytes
	movq	%rax, %rdi
	call	quote_var
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leave
	ret
