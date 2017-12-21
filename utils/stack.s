# Stack-oriented functions meant to be called in succession, Forth-style
.type	dup, @function
dup:
	popq	%rdi
	pushq	(%rsp)
	pushq	%rdi
	ret
.type	inc, @function
inc:				# : inc 1 + ;
	incq	8(%rsp)
	ret
.type	dub, @function
dub:				# : dub dup + ;
	movq	8(%rsp), %rax
	addq	%rax, 8(%rsp)
	ret
.type	sub, @function
sub:				# : sub - ;
	popq	%rdi
	popq	%rax
	subq	%rax, (%rsp)
	pushq	%rdi
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
cr:				# Identical to terpri
	movq	$10, %rdi
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
