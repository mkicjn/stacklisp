.include "inclusions.s"

teststr:
	.string "sym"

xstr:
	.string "0x%x\n"

print_addr:
	leaq	xstr(%rip), %rdi
	movq	8(%rsp), %rsi
	xorq	%rax, %rax
	call	printf@plt
	ret

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	movl	$10, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	leaq	teststr(%rip), %rdi
	movl	$1, %esi
	call	new_var
	pushq	%rax

	movl	$30, %edi
	movl	$2, %esi
	call	new_var
	pushq	%rax

	call	cons # (sym . 30)
	call	cons # (10 sym . 30)

	call	print_addr
	call	dup
	call	print
	call	terpri
	call	drop
	call	copy
	call	print_addr
	call	print
	call	terpri
	call	drop
	call	drop

	leave
	ret
