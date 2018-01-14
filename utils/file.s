rstr:
	.string	"r"

.type	read_file, @function
read_file: # Standard calling convention
	# Filename in %rdi
	leaq	rstr(%rip), %rsi
	call	fopen@plt
	pushq	%rax
	movq	%rax, %rdi
	xorq	%rsi, %rsi
	movl	$2, %edx
	call	fseek@plt
	movq	(%rsp), %rdi
	call	ftell@plt
	pushq	%rax
	movq	8(%rsp), %rdi
	call	rewind@plt
	movq	(%rsp), %rdi
	incq	%rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rdx
	popq	%rcx
	movl	$1, %esi
	pushq	%rdi
	pushq	%rcx
	call	fread@plt
	movq	8(%rsp), %rdi
	call	to_var
	movq	%rax, 8(%rsp)
	popq	%rdi
	call	fclose@plt
	popq	%rax
	ret
