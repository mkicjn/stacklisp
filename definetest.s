.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	.main_loop:
	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	pushq	%rax
	call	car
	call	swap
	call	cdr
	call	define

	pushq	ENV(%rip)
	call	disp
	call	drop
	call	terpri

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	call	reference
	call	disp
	call	drop
	call	terpri
	jmp	.main_loop # Infinite loop. Sloppy, but works

	leave
	ret
