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
	.quad	2,10
y:
	.quad	2,20
f1:	# (lambda (x y) (* y (- y x))) => (y y x - *)
	.quad	-3,1,2,1,2,1,1,lsub,lmul,0,0
	#f:	#(2 arg function)
	#	push	arg2
	#	push	arg2
	#	push	arg1
	#	call	lsub
	#	call	lmul
	#	return #(not ret!)

f2:	# (lambda () (* 20 (- 20 10))) => (20 20 10 - *)
	.quad	-1,0,y,0,y,0,x,lsub,lmul,0,0

.macro	peaq	mem
	leaq	\mem(%rip), %rax
	pushq	%rax
.endm

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	peaq	x
	peaq	y
	peaq	f1
	call	funcall
	call	disp
	call	drop
	call	terpri
	peaq	f2
	call	funcall
	call	disp
	call	drop
	call	terpri

	leave
	ret
