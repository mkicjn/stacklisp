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
	call	sscanf@plt
	popq	%rax
	ret
	.to_var1:
	popq	%rdi
	movq	$1, %rsi
	call	new_var
	ret
	.to_var0:
	# This one's a little more complicated -- To be written
	.to_var_err:
	addq	$8, %rsp # drop
	leaq	NIL(%rip), %rax
	ret

.type	to_space, @function
to_space: # Standard calling convention
	pushq	%rdi
	xorq	%rax, %rax
	movq	$-1, %rcx
	.to_space_loop:
	incq	%rcx
	cmpb	$0, (%rdi,%rcx,1)
	jz	.to_space_break
	cmpb	$32, (%rdi,%rcx,1)
	jne	.to_space_loop
	push	%rcx
	movq	%rcx, %rdi
	call	malloc@plt
	pushq	%rax
	movq	%rax, %rdi
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rdx
	call	memcpy@plt
	popq	%rax
	call	drop
	call	drop
	.to_space_break:
	ret

.type	to_paren, @function
to_paren: # Standard calling convention
	pushq	%rdi
	xorq	%rax, %rax
	xorq	%rdx, %rdx
	movq	$-1, %rcx
	.to_paren_loop:
	incq	%rcx
	cmpb	$0, (%rdi,%rcx,1)
	jz	.to_paren_break
	cmpb	$40, (%rdi,%rcx,1)
	je	.to_paren_lp
	cmpb	$41, (%rdi,%rcx,1)
	je	.to_paren_rp
	jmp	.to_paren_loop
	.to_paren_lp:
	incq	%rdx
	jmp	.to_paren_loop
	.to_paren_rp:
	decq	%rdx
	cmpq	$0, %rdx
	jne	.to_paren_loop
	incq	%rcx
	pushq	%rcx
	movq	%rcx, %rdi
	call	malloc@plt
	movq	%rax, %rdi
	popq	%rdx
	popq	%rsi
	pushq	%rdi
	call	memcpy@plt
	.to_paren_break:
	popq	%rax
	ret

.type	read_str, @function
read_str: # Standard calling convention
	leaq	NIL(%rip), %rax
	pushq	%rax
	decq	%rdi
	.read_str_loop:
	incq	%rdi
	cmpb	$0, (%rdi)	# Check for end of string
	jz	.read_str_ret
	cmpb	$40, (%rdi)	# Check for open parenthesis
	je	.read_str_list
				# Checks for whitespace
	cmpb	$32, (%rdi)
	je	.read_str_loop
	cmpb	$13, (%rdi)
	je	.read_str_loop
	cmpb	$10, (%rdi)
	je	.read_str_loop
	cmpb	$9, (%rdi)
	je	.read_str_loop
				# Must be an atom, then
	pushq	%rdi
	call	to_space
	pushq	%rax
	movq	%rax, %rdi
	call	strlen@plt
	popq	%rdi
	addq	%rax, (%rsp) # Add string length to string pointer
	call	to_var
	popq	%rdi
	pushq	%rax
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	jmp	.read_str_loop
	.read_str_list:
	#############################
	pushq	%rdi
	call	to_paren
	pushq	%rax
	movq	%rax, %rdi
	call	strlen@plt
	popq	%rdi
	addq	%rax, (%rsp) # Add string length to string pointer
	call	read_str
	popq	%rdi
	pushq	%rax
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	nconc
	jmp	.read_str_loop
	#############################
	.read_str_ret:
	ret #########################
