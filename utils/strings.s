.type	toupper, @function
toupper:
	pushq	%rdi
	.toupperl:
	cmpb	$0, (%rdi)
	jz	.toupperq
	cmpb	$97, (%rdi)
	jnge	.toupperc
	cmpb	$122, (%rdi)
	jnle	.toupperc
	subq	$32, (%rdi)
	.toupperc:
	incq	%rdi
	jmp	.toupperl
	.toupperq:
	popq	%rax
	ret

.type	chomp, @function
chomp:
	pushq	%rdi
	.chomp_l:
	cmpb	$10, (%rdi)
	je	.chomp_x
	cmpb	$0, (%rdi)
	je	.chomp_q
	incq	%rdi
	jmp	.chomp_l
	.chomp_x:
	movq	$0, (%rdi)
	.chomp_q:
	popq	%rax
	ret

.type	skip_white, @function
skip_white:
	decq	%rdi
	.read_list_white:
	incq	%rdi
	cmpb	$9, (%rdi) # Horizontal tab
	je	.read_list_white
	cmpb	$10, (%rdi) # Line feed (Newline)
	je	.read_list_white
	cmpb	$13, (%rdi) # Carriage return
	je	.read_list_white
	cmpb	$32, (%rdi) # Space
	je	.read_list_white
	movq	%rdi, %rax
	ret

.type	strclone, @function
strclone:
	pushq	%rdi
	call	strlen@plt
	movq	%rax, %rdi
	incq	%rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rsi
	call	strcpy@plt
	ret
