# Stack-oriented functions to be called in succession, Forth-style
.type	dup, @function
dup:
	popq	%rax
	pushq	(%rsp)
	pushq	%rax
	ret
.type	swap, @function
swap:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rax, 16(%rsp)
	movq	%rcx, 8(%rsp)
	ret
.type	drop, @function
drop:
	popq	(%rsp) # nip (drop stack item under return address)
	ret
.type	emit, @function
emit:
	movq	8(%rsp), %rdi
	call	putchar@plt
	popq	(%rsp)
	ret
.type	cr, @function
cr:
	movl	$10, %edi
	call	putchar@plt
	ret
.type	pick, @function
pick:
	movq	8(%rsp), %rax
	incq	%rax
	movq	(%rsp,%rax,8), %rax
	movq	%rax, 8(%rsp)
	ret
.type	over, @function
over:
	popq	%rdi
	pushq	8(%rsp)
	pushq	%rdi
	ret
.type	nip, @function
nip:
	movq	8(%rsp), %rax
	movq	%rax, 16(%rsp)
	popq	(%rsp)
	ret
.type	tuck, @function
tuck:
	movq	16(%rsp), %rax
	movq	8(%rsp), %rcx
	pushq	(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rax, 16(%rsp)
	movq	%rcx, 8(%rsp)
	ret
.type	rot, @function
rot:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rcx, 24(%rsp)
	movq	%rax, 16(%rsp)
	movq	%rdx, 8(%rsp)
	ret
.type	unrot, @function
unrot:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 24(%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rcx, 8(%rsp)
	ret
iform:
	.string "%li "
.type	dot, @function
dot:
	leaq	iform(%rip), %rdi
	movq	8(%rsp), %rsi
	xorq	%rax, %rax
	call	printf@plt
	popq	(%rsp)
	ret
