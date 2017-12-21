.macro	chain	func
	call	\func
	movq	%rax, %rdi
.endm

.macro	zero	reg
	xorq	\reg, \reg
.endm

.macro	car	reg
	movq	8(\reg), \reg
.endm

.macro	cdr	reg
	movq	16(\reg), \reg
.endm

.macro	error	code msg
	leaq	\msg(%rip), %rdi
	call	puts@plt
	movq	\code, %rdi
	call	exit@plt
.endm
