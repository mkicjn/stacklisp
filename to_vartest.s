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
	call	to_var
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leaq	str2(%rip), %rdi
	call	to_var
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	########### Skip 3 for now ###########

	leaq	str4(%rip), %rdi
	call	to_var
	pushq	%rax
	call	disp
	call	drop
	call	terpri

	leave
	ret
