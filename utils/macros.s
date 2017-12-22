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

.macro	debug_disp
	call	dup
	call	disp
	call	drop
	call	terpri
.endm

.macro	debug_disp_rdi
	pushq	%rdi
	call	dup
	call	disp
	call	drop
	popq	%rdi
	call	terpri
.endm
