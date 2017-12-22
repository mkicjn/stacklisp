.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	# Pretend these are addresses
	pushq	$1
	pushq	$2
	pushq	$3
	pushq	$4
	pushq	$5
	call	nip
	call	dup
	call	printint
	call	drop
	call	drop
	call	printint
	call	drop
	call	printint

	leave
	ret
