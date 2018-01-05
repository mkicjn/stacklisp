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
	movq	$2, %rdx
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
	movq	$1, %rsi
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
