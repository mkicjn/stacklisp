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
x:
	.quad	2,3
y:
	.quad	2,4
fnil:
	.quad	-1,0xa1,NIL,0xee
f:	# (lambda (x y) (* y (- y x))) => (y y x - *)
	.quad	-3,0xaa,2,0xaa,2,0xaa,1,lsub,lmul,0xee
g:	# (lambda () (* x (- (f x y) x))) => (y x y f x - *)
	.quad	-3,0xa1,y,0xa1,x,0xa1,y,0xca,f,0xa1,x,lsub,lmul,0xee
cadr:	# (lambda (x) (car (cdr x))) -> (x cdr car)
	.quad	-2,0xaa,1,0xca,dict_cdr_var,0xca,dict_car_var,0xee
stest:	# (lambda () (list x y)) => ({NULL} x y list)
	.quad	-2,0xa1,0x0,0xa1,x,0xa1,y,0xca,dict_list_var,0xee
condt:	# (lambda (x) (cond ((eq x 3) 1) (t 2))) => ({COND} {PUSH_ARG} 1 3 eq {CASE} 1 {CASE_END} t {CASE} 2 {CASE_END} NIL {COND_END})
	.quad	-2,0xc0,0xaa,1,0xa1,x,dict_eq_sym,0xc1,one,0xc2,NIL,0xc3,0xee
	
.macro	peaq	mem
	leaq	\mem(%rip), %rax
	pushq	%rax
.endm

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	peaq	y
	peaq	condt
	call	funcall
	call	disp
	call	drop
	call	terpri

	leave
	ret
