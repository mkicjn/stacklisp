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
	# (lambda (x) (cons 0 (cond ((eq x 1) 0) (t 1))))
	# (0 {COND} {PUSH_ARG} {0x1} 1 eq {CALL} {CASE} 0 {CASE_END} T {CASE} 1 {CASE_END} NIL {COND_END} cons {CALL})
	.quad	-2,zero,0xc0,0xaa,0x1,one,dict_eq_sym,0xca,0xc1,zero,0xc2,T,0xc1,one,0xc2,NIL,0xc3,dict_cons_sym,0xca,0xee,0xfe

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
