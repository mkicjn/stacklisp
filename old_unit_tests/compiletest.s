.include "inclusions.s"

zero:
	.quad	2,0
one:
	.quad	2,1
x:
	.quad	2,3
y:
	.quad	2,4
condt:	# (lambda (x) (cond ((eq x 3) 1) (t 2))) => ({COND} {PUSH_ARG} 1 3 eq {CASE} 1 {CASE_END} t {CASE} 2 {CASE_END} NIL {COND_END})
	.quad	-2,0xc0,0xaa,1,0xa1,x,dict_eq_sym,0xc1,one,0xc2,NIL,0xc3,0xee,0xfe
	
.macro	peaq	mem
	leaq	\mem(%rip), %rax
	pushq	%rax
.endm

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$200, %edi
	call	read_bytes
	pushq	%rax
	movl	$200, %edi
	call	read_bytes
	pushq	%rax
	call	rpn
	dddt
	call	subst_args
	dddt
	movq	(%rsp), %rdi
	call	scc_length
	leaq	24(,%rax,8), %rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rsi
	popq	(%rdi)
	call	compile
########
	movq	%rax, %rdi
	call	decompile
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leave
	ret
