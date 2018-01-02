.include "inclusions.s"

.type	lsub, @function
lsub:
	movq	16(%rsp), %rdi
	movq	8(%rdi), %rdi
	movq	8(%rsp), %rax
	subq	8(%rax), %rdi
	movq	$2, %rsi
	call	new_var
	popq	%rdi
	movq	%rax, 8(%rsp)
	movq	%rdi, (%rsp)
	ret
lmul:
	movq	16(%rsp), %rax
	movq	8(%rax), %rax
	movq	8(%rsp), %rdi
	mulq	8(%rdi)
	movq	%rax, %rdi
	movq	$2, %rsi
	call	new_var
	popq	%rdi
	movq	%rax, 8(%rsp)
	movq	%rdi, (%rsp)
	ret

zero:
	.quad	2,0
one:
	.quad	2,1
f:
	# (lambda '(x) '(cons x (cons 0 nil)))
	# ({PUSH_ARG} {0x1} {PUSH} x NIL cons {CALL} cons {CALL} {RETURN})
	.quad	-2,0xaa,1,zero,NIL,dict_cons_sym,0xca,dict_cons_sym,0xca,0xee,0xfe

.macro	peaq	mem
	leaq	\mem(%rip), %rax
	pushq	%rax
.endm

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	peaq	one
	peaq	f
	call	funcall
	call	disp
	call	drop
	call	terpri

	leave
	ret
