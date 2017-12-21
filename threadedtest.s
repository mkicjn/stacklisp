.include "utils/stack.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
				# 10 65 inc dub swap sub emit cr
	pushq	$10
	pushq	$65
	call	inc
	call	dub
	call	swap
	call	sub
	call	emit
	call	cr
				# bye
	leave
	ret
