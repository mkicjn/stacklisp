.type	nconc, @function
nconc:
	pushq	16(%rsp) # Fetch the list
	.append_loop:
	call	dup
	call	cdr
	call	zornil
	cmpq	$1, %rax
	call	drop
	je	.append_do
	call	cdr
	jmp	.append_loop
	.append_do:
	popq	%rdi
	movq	8(%rsp), %rax
	movq	%rax, 16(%rdi)
	popq	(%rsp) # Nip
	ret
