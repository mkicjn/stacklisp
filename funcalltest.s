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
fnil:
	.quad	-1,0xaf,NIL,0xee
f:	# (lambda (x y) (* y (- y x))) => (y y x - *)
	#.quad	-3,0xaa,2,0xaa,2,0xaa,1,lsub,lmul,0xca,0
	.quad	-3,0xaa,2,0xaa,1,lsub,0xee

g:	# (lambda () (* 20 (- (f 10 20) 10))) => (20 10 20 f 10 - *)
	.quad	-1,0xaf,y,0xaf,x,0xaf,y,0xca,f,0xaf,x,lsub,lmul,0xee
	
	

.macro	peaq	mem
	leaq	\mem(%rip), %rax
	pushq	%rax
.endm

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

/*
	peaq	x
	peaq	y
	peaq	f
	call	funcall
	call	disp
	call	drop
	call	terpri
*/
	peaq	g
	call	funcall
	call	disp
	call	drop
	call	terpri

	leave
	ret
