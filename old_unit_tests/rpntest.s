.include "inclusions.s"

plus:
	.string	"+"
minus:
	.string	"-"

.macro	pushivar n
	movq	\n, %rdi
	call	new_ivar
	pushq	%rax
.endm
.macro	pushsvar s
	leaq	\s(%rip), %rdi
	call	new_svar
	pushq	%rax
.endm
.macro	pushnil
	leaq	NIL(%rip), %rax
	pushq	%rax
.endm

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

#	(+ (- 2 (- 3 (+ 1 1))) 2)
	pushsvar	plus
	pushsvar	minus
	pushivar	$2
	pushsvar	minus
	pushivar	$3
	pushsvar	plus
	pushivar	$1
	pushivar	$1
	pushnil		# NIL
	call	cons
	call	cons
	call	cons
	pushnil		# NIL
	call	cons
	call	cons
	call	cons
	pushnil		# NIL
	call	cons
	call	cons
	call	cons
	pushivar	$2
	pushnil		# NIL
	call	cons
	call	cons
	call	cons
#	(+ (- 2 (- 3 (+ 1 1))) 2)

	call	dup
	call	disp
	call	drop
	call	terpri
	call	copy
	call	rpn
	call	disp # Expect (2 3 1 1 + - - 2 +)
	call	drop
	call	terpri

	leave
	ret

# Note: The original should eval to 3 in Lisp.
#	The translation should push 3 to the stack in Forth.
