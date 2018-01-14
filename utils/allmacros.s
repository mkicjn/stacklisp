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

.macro	dd
	call	disp
	call	drop
.endm

.macro	ddd
	call	dup
	dd
.endm

.macro	ddt
	dd
	call	scc_terpri
.endm

.macro	dddt
	ddd
	call	scc_terpri
.endm

.macro	debug_disp_rdi
	pushq	%rdi
	call	dup
	call	disp
	call	drop
	popq	%rdi
	call	scc_terpri
.endm

.macro	pushregs
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rdi
	pushq	%rsi
.endm

.macro	popregs
	popq	%rsi
	popq	%rdi
	popq	%rdx
	popq	%rcx
	popq	%rax
.endm

.macro	tab
	pushregs
	movl	$'\t', %edi
	call	putchar@plt
	popregs
.endm

pushstr:
	.string	"\tPUSH"
popstr:
	.string	"\tPOP"

.macro	dpushq	reg
	pushregs
	pushq	\reg
	leaq	pushstr(%rip), %rdi
	call	puts@plt
	popregs
.endm

.macro	dpopq	reg
	pushregs
	popq	\reg
	leaq	popstr(%rip), %rdi
	call	puts@plt
	popregs
.endm
