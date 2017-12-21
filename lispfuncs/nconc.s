.type	nconc, @function
nconc:
	pushq	16(%rsp) # Fetch the list
	.nconc_loop:
	call	dup
	call	cdr
	call	zornil
	cmpq	$1, %rax
	call	drop
	je	.nconc_do
	call	cdr
	jmp	.nconc_loop
	.nconc_do:
	popq	%rdi
	movq	8(%rsp), %rax
	movq	%rax, 16(%rdi)
	popq	(%rsp) # Nip
	ret
