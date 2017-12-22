.include "inclusions.s"

str1:
	.string "1234567890"
str2:
	.string "abcdefghij"
str3:
	.string "(1 2 3 4 5 6 7 8 9 0)"
str4:
	.string "((((test)))"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	str1(%rip), %rdi
	call	infer_type
	pushq	%rax
	call	printint
	leaq	str2(%rip), %rdi
	call	infer_type
	pushq	%rax
	call	printint
	leaq	str3(%rip), %rdi
	call	infer_type
	pushq	%rax
	call	printint
	leaq	str4(%rip), %rdi
	call	infer_type
	pushq	%rax
	call	printint

	leave
	ret
