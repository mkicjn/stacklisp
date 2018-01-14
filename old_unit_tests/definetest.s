.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	.main_loop:
	movl	$200, %edi
	call	read_bytes
	pushq	%rax
	pushq	%rax
	call	car
	call	swap
	call	cdr
	call	car
	call	define

	pushq	ENV(%rip)
	call	print
	call	drop
	call	terpri

	movl	$200, %edi
	call	read_bytes
	pushq	%rax
	call	reference
	call	print
	call	drop
	call	terpri
	jmp	.main_loop # Infinite loop. Sloppy, but works

	leave
	ret
