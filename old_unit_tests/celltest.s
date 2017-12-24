.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	# Pretend these are addresses
	pushq	$1
	pushq	$2
	call	cons
	call	dup
	call	car
	call	printint
	call	drop
	call	cdr
	call	printint
	call	drop

	leave
	ret
