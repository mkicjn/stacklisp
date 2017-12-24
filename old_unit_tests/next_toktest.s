.include "inclusions.s"

str:
	.string "(123 456 789)"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	str(%rip), %rdi
	incq	%rdi

	pushq	%rdi # string
	call	next_tok
	pushq	%rax # token
	movq	%rax, %rdi
	call	puts@plt
	popq	%rdi # token
	call	strlen@plt
	popq	%rdi # string
	incq	%rax
	addq	%rax, %rdi

	pushq	%rdi # string
	call	next_tok
	pushq	%rax # token
	movq	%rax, %rdi
	call	puts@plt
	popq	%rdi # token
	call	strlen@plt
	popq	%rdi # string
	incq	%rax
	addq	%rax, %rdi

	pushq	%rdi # string
	call	next_tok
	pushq	%rax # token
	movq	%rax, %rdi
	call	puts@plt
	popq	%rdi # token
	call	strlen@plt
	popq	%rdi # string
	incq	%rax
	addq	%rax, %rdi

	leave
	ret
