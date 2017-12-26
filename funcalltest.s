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

x:
	.quad	2,3
y:
	.quad	2,4
fnil:
	.quad	-1,0xaf,NIL,0xee
f:	# (lambda (x y) (* y (- y x))) => (y y x - *)
	.quad	-3,0xaa,2,0xaa,2,0xaa,1,lsub,lmul,0xee
g:	# (lambda () (* x (- (f x y) x))) => (y x y f x - *)
	.quad	-3,0xaf,y,0xaf,x,0xaf,y,0xca,f,0xaf,x,lsub,lmul,0xee
cadr:	# (lambda (x) (car (cdr x))) -> (x cdr car)
	.quad	-2,0xaa,1,0xca,dict_cdr_var,0xca,dict_car_var,0xee
	
.macro	peaq	mem
	leaq	\mem(%rip), %rax
	pushq	%rax
.endm

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$200, %rdi
	call	new_ivar
	pushq	%rax
	call	lread
	peaq	cadr
	call	funcall
	call	disp
	call	drop
	call	terpri

	leave
	ret
