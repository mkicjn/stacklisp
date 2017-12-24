.type	infer_type, @function
infer_type: # Standard calling convention
	xorq	%rcx, %rcx
	cmpb	$40, (%rdi)
	je	.infer_type0
	.infer_type_loop:
	cmpb	$0, (%rdi)
	jz	.infer_type2
	cmpb	$48, (%rdi)
	jnge	.infer_type1
	cmpb	$57, (%rdi)
	jnle	.infer_type1
	incq	%rdi
	jmp	.infer_type_loop
	.infer_type2:
	movq	$2, %rax
	ret
	.infer_type1:
	movq	$1, %rax
	ret
	.infer_type0:
	cmpb	$40, (%rdi)
	je	.infer_type0_lp
	cmpb	$41, (%rdi)
	je	.infer_type0_rp
	cmpb	$0, (%rdi)
	jz	.infer_type0_ret
	incq	%rdi
	jmp	.infer_type0
	.infer_type0_lp:
	incq	%rcx
	incq	%rdi
	jmp	.infer_type0
	.infer_type0_rp:
	decq	%rcx
	incq	%rdi
	jmp	.infer_type0
	.infer_type0_ret:
	cmpq	$0, %rcx
	jnz	.infer_type_err
	xorq	%rax, %rax
	ret
	.infer_type_err:
	movq	$-1, %rax
	ret

scanl:
	.string	"%li"

.type	to_var, @function
to_var: # Standard calling convention
	pushq	%rdi
	call	infer_type
	cmpq	$2, %rax
	je	.to_var2
	cmpq	$1, %rax
	je	.to_var1
	cmpq	$0, %rax
	je	.to_var0
	cmpq	$-1, %rax
	je	.to_var_err
	.to_var2:
	movq	$24, %rdi
	call	malloc@plt
	movq	$2, (%rax)
	popq	%rdi			# string
	pushq	%rax
	leaq	scanl(%rip), %rsi	# format
	leaq	8(%rax), %rdx		# &long
	xorq	%rax, %rax		# No floating point arguments
	call	sscanf@plt
	popq	%rax
	ret
	.to_var1:
	popq	%rdi
	movq	$1, %rsi
	call	new_var
	ret
	.to_var0:
	popq	%rdi
	call	read_list
	ret
	.to_var_err:
	addq	$8, %rsp # drop
	leaq	NIL(%rip), %rax
	ret

.type	captok, @function
captok: # Standard calling convention
	xorq	%rax, %rax
	movq	$-1, %rcx
	.captok_loop:
	incq	%rcx
	cmpb	$0, (%rdi,%rcx,1) # Null
	jz	.captok_break
	cmpb	$32, (%rdi,%rcx,1) # Space
	je	.captok_ret
	cmpb	$41, (%rdi,%rcx,1) # Right parenthesis
	je	.captok_ret
	cmpb	$9, (%rdi,%rcx,1) # Horizontal tab
	je	.captok_ret
	cmpb	$10, (%rdi,%rcx,1) # Line feed (Newline)
	je	.captok_ret
	cmpb	$13, (%rdi,%rcx,1) # Carriage return
	je	.captok_ret
	jmp	.captok_loop
	.captok_ret:
	pushq	%rdi
	pushq	%rcx
	movq	%rcx, %rdi
	incq	%rdi ###
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rdx
	popq	%rsi
	pushq	%rdi
	call	memcpy@plt
	popq	%rax
	.captok_break:
	ret

.type	caplist, @function
caplist: # Standard calling convention
	pushq	%rdi
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	movq	$-1, %rcx
	.caplist_loop:
	incq	%rcx
	cmpb	$0, (%rdi,%rcx,1)
	jz	.caplist_break
	cmpb	$40, (%rdi,%rcx,1)
	je	.caplist_lp
	cmpb	$41, (%rdi,%rcx,1)
	je	.caplist_rp
	jmp	.caplist_loop
	.caplist_lp:
	incq	%rdx
	jmp	.caplist_loop
	.caplist_rp:
	decq	%rdx
	cmpq	$0, %rdx
	jne	.caplist_loop
	incq	%rcx
	pushq	%rcx
	movq	%rcx, %rdi
	incq	%rdi ###
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rdx
	popq	%rsi
	pushq	%rdi
	call	memcpy@plt
	.caplist_break:
	popq	%rax
	ret

.type	next_tok, @function
next_tok: # Standard calling convention
	cmpb	$40, (%rdi) # Left parenthesis
	je	.next_tok_lp
	call	captok
	ret
	.next_tok_lp:
	call	caplist
	ret

.type	read_list, @function
read_list: # Standard calling convention
	call	skip_white
	movq	%rax, %rdi
	pushq	%rdi # string
	call	infer_type
	cmpq	$0, %rax
	jnz	.read_list_atom
	leaq	NIL(%rip), %rax
	pushq	%rax # list
	incq	8(%rsp)
	.read_list_loop:
	movq	8(%rsp), %rdi
	call	skip_white
	movq	%rax, %rdi
	movq	%rdi, 8(%rsp)
	cmpb	$46, (%rdi) # Period
	je	.read_list_dot
	cmpb	$41, (%rdi) # Right parenthesis
	je	.read_list_ret
	call	next_tok
	cmpq	$0, %rax
	jz	.read_list_ret
	pushq	%rax # token string
	movq	%rax, %rdi
	call	strlen@plt
	incq	%rax
	addq	%rax, 16(%rsp) # Skip string to next pointer
	popq	%rdi # token string
	call	to_var
	pushq	%rax # var
	leaq	NIL(%rip), %rax
	pushq	%rax # nil
	call	cons
	call	nconc
	jmp	.read_list_loop
	.read_list_atom:
	popq	%rdi
	call	skip_white
	movq	%rax, %rdi
	call	to_var
	ret
	.read_list_dot:
	incq	%rdi
	call	skip_white
	movq	%rax, %rdi
	call	next_tok
	movq	%rax, %rdi
	cmpb	$0, (%rax)
	jz	.read_list_ret
	movq	%rax, %rdi
	call	to_var
	pushq	%rax
	call	nconc
	.read_list_ret:
	popq	%rax
	addq	$8, %rsp
	ret

.type	read_bytes, @function
read_bytes: # Standard calling convention.
	pushq	%rdi
	incq	%rdi
	call	malloc@plt
	popq	%rdx
	pushq	%rax
	xorq	%rdi, %rdi
	movq	%rax, %rsi
	call	read@plt
	movq	(%rsp), %rdi
	call	chomp
	movq	(%rsp), %rdi
	call	read_list
	addq	$8, %rsp ############
	# The following breaks things for some reason
	#popq	%rdi
	#pushq	%rax
	#call	free@plt
	#popq	%rax
	ret

.type	lread, @function
lread: # Stack-oriented. Expects number of bytes to read from stdin as var on stack.
	movq	8(%rsp), %rax
	movq	8(%rax), %rdi
	call	read_bytes
	movq	%rax, 8(%rsp)
	ret
