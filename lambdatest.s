.include "inclusions.s"

teststr:
	.string	"test"
testvar:
	.quad	1,teststr,0

testfun: # decompiled: ({PUSH} x {PUSH_ARG} {0x1} cons {RETURN})
	.quad	-2,0xa1,testvar,0xaa,1,dict_cons_sym,0xee,0xfe

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$200, %rdi
	call	read_bytes
	pushq	%rax
	call	dup
	call	car
	call	swap
	call	cdr
	call	car
	call	lambda
	movq	(%rsp), %rdi
	addq	$8, %rdi
	call	decompile
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leaq	testvar(%rip), %rax
	pushq	%rax
	call	over
	call	funcall
	call	disp
	call	drop
	call	terpri
	call	drop

	leave
	ret
