.type	infer_type, @function
infer_type: # Standard calling convention
	cmpb	$'\'', (%rdi)
	jne	.infer_type_no_quote
	incq	%rdi
	.infer_type_no_quote:
	xorq	%rcx, %rcx
	cmpb	$'(', (%rdi)
	je	.infer_type0
	cmpb	$0, (%rdi)
	jz	.infer_type1
	.infer_type_loop:
	cmpb	$0, (%rdi)
	jz	.infer_type2
	cmpb	$'0', (%rdi)
	jnge	.infer_type1
	cmpb	$'9', (%rdi)
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
	cmpb	$'(', (%rdi)
	je	.infer_type0_lp
	cmpb	$')', (%rdi)
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

.type	quote_var, @function
quote_var: # Standard calling convention
	leaq	dict_quote_sym(%rip), %rax
	pushq	%rax
	pushq	%rdi
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	cons
	popq	%rax
	ret

.type	to_var, @function
to_var: # Standard calling convention
	xorq	%r10, %r10
	cmpb	$'\'', (%rdi)
	jne	.to_var_nq
	incq	%rdi
	movq	$1, %r10
	.to_var_nq:
	call	sspush_10
	pushq	%rdi
	call	infer_type
	cmpq	$2, %rax
	je	.to_var2
	cmpq	$1, %rax
	je	.to_var1
	cmpq	$0, %rax
	je	.to_var0
	cmpq	$-1, %rax
	je	.to_var_nil
	.to_var2:
	call	sspop_10
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
	movq	(%rsp), %rdi
	cmpb	$0, (%rdi)
	jz	.to_var_nil
	# Check if NIL
	movq	(%rsp), %rdi
	leaq	NILstr(%rip), %rsi
	call	strcasecmp@plt
	cmpq	$0, %rax
	movq	(%rsp), %rdi
	jz	.to_var_nil
	# Check if T
	leaq	Tstr(%rip), %rsi
	call	strcasecmp@plt
	cmpq	$0, %rax
	jz	.to_var_t
	# Convert to var, quote if quoted
	popq	%rdi
	movq	$1, %rsi
	call	new_var
	call	sspop_10
	cmpq	$1, %r10
	je	.to_var_quote
	ret
	.to_var0:
	popq	%rdi
	call	read_str
	call	sspop_10
	cmpq	$1, %r10
	je	.to_var_quote
	ret
	.to_var_quote:
	movq	%rax, %rdi
	call	quote_var
	ret
	.to_var_nil:
	call	sspop_10
	addq	$8, %rsp # drop
	leaq	NIL(%rip), %rax
	ret
	.to_var_t:
	call	sspop_10
	addq	$8, %rsp # drop
	leaq	T(%rip), %rax
	ret

.type	captok, @function
captok: # Standard calling convention
	xorq	%rax, %rax
	movq	$-1, %rcx
	.captok_loop:
	incq	%rcx
	cmpb	$0, (%rdi,%rcx,1) # Null
	jz	.captok_break
	cmpb	$' ', (%rdi,%rcx,1) # Space
	je	.captok_ret
	cmpb	$')', (%rdi,%rcx,1) # Right parenthesis
	je	.captok_ret
	cmpb	$'\t', (%rdi,%rcx,1) # Horizontal tab
	je	.captok_ret
	cmpb	$'\n', (%rdi,%rcx,1) # Line feed (Newline)
	je	.captok_ret
	cmpb	$'\r', (%rdi,%rcx,1) # Carriage return
	je	.captok_ret
	jmp	.captok_loop
	.captok_ret:
	pushq	%rdi
	pushq	%rcx
	movq	%rcx, %rdi
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
	cmpb	$'(', (%rdi,%rcx,1)
	je	.caplist_lp
	cmpb	$')', (%rdi,%rcx,1)
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
	incq	%rdi
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
	movq	(%rdi), %rax
	cmpb	$'\'', %al
	jne	.next_tok_no_quote
	movq	1(%rdi), %rax
	.next_tok_no_quote:
	cmpb	$'(', %al # Left parenthesis
	je	.next_tok_lp
	call	captok
	ret
	.next_tok_lp:
	call	caplist
	ret

.type	read_str, @function
read_str: # Standard calling convention
	call	skip_white
	movq	%rax, %rdi
	pushq	%rdi # string
	call	infer_type
	cmpq	$0, %rax
	jnz	.read_str_atom
	leaq	NIL(%rip), %rax
	pushq	%rax # list
	incq	8(%rsp)
	.read_str_loop:
	movq	8(%rsp), %rdi
	call	skip_white
	movq	%rax, %rdi
	movq	%rdi, 8(%rsp)
	cmpb	$'.', (%rdi) # Period
	je	.read_str_dot
	cmpb	$')', (%rdi) # Right parenthesis
	je	.read_str_ret
	call	next_tok
	cmpq	$0, %rax
	jz	.read_str_ret
	pushq	%rax # token string
	movq	%rax, %rdi
	call	strlen@plt
	addq	%rax, 16(%rsp) # Skip string to next pointer
	popq	%rdi # token string
	call	to_var
	pushq	%rax # var
	leaq	NIL(%rip), %rax
	pushq	%rax # nil
	call	cons
	call	nconc
	jmp	.read_str_loop
	.read_str_atom:
	popq	%rdi
	call	skip_white
	movq	%rax, %rdi
	call	to_var
	ret
	.read_str_dot:
	incq	%rdi
	call	skip_white
	movq	%rax, %rdi
	call	next_tok
	movq	%rax, %rdi
	cmpb	$0, (%rax)
	jz	.read_str_ret
	movq	%rax, %rdi
	call	to_var
	pushq	%rax
	call	nconc
	.read_str_ret:
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
	call	to_var
#	addq	$8, %rsp
	popq	%rdi
	pushq	%rax
	call	free@plt
	popq	%rax
	ret
