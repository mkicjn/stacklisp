fnum:
	.string "%li"
fstr:
	.string "%s"
fdub:
	.string "%lf"
ffun:
	.string	"{FUNCTION}"
fspec:
	.string	"{SPECIAL}"

.type	disp, @function #|disp|
disp:
	movq	8(%rsp), %rdi
	cmpq	$0xff, %rdi
	jle	.disp_flag
	cmpq	NILptr(%rip), %rdi
	je	.disp_nil
	cmpq	$0, (%rdi)
	jz	.disp_cell
	jl	.disp_func
	cmpq	$1, (%rdi)
	je	.disp_sym
	cmpq	$2, (%rdi)
	je	.disp_num
	cmpq	$3, (%rdi)
	je	.disp_func
	cmpq	$4, (%rdi)
	je	.disp_dub
	jmp	.disp_exit # Unknown datatype
	.disp_flag:
	call	disp_flag
	jmp	.disp_exit
	.disp_nil:
	leaq	NILstr(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.disp_exit
	.disp_sym:
	movq	8(%rdi), %rsi
	leaq	fstr(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.disp_exit
	.disp_num:
	movq	8(%rdi), %rsi
	leaq	fnum(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.disp_exit
	.disp_func:
	leaq	ffun(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.disp_exit
	.disp_dub:
	movsd	16(%rdi), %xmm0
	leaq	fdub(%rip), %rdi
	movq	$1, %rax
	call	printf@plt
	jmp	.disp_exit
	.disp_cell:
	movq	$40, %rdi
	call	putchar@plt # (

	pushq	8(%rsp) # Push the cell to the stack
	.disp_cell_l:
	call	dup # Duplicate the list
	call	car # Replace duplicate with head
	call	disp # Print the head (and drop from stack)
	call	drop

	movq	$32, %rdi
	call	putchar@plt # space

	call	cdr # Get the cell's tail
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	jz	.disp_cell_lx 
	movq	(%rsp), %rdi
	cmpq	$0xff, %rdi # Is the tail a flag?
	jle	.disp_cell_pd # Don't check type
	cmpq	$0, (%rdi) # Is tail another list?
	jz	.disp_cell_l

	.disp_cell_pd:
	# Tail must be a non-nil atom
	movq	$46, %rdi # .
	call	putchar@plt
	movq	$32, %rdi # space
	call	putchar@plt

	#pushq	(%rsp) # LAZY HACK: Dupe so disp_cell_lx has something to remove
	call	disp

	movq	$32, %rdi # space
	call	putchar@plt

	.disp_cell_lx: # Done printing list
	popq	%rdi # Drop top stack item
	movq	$8, %rdi
	call	putchar@plt # backspace (LAZY HACK)
	movq	$41, %rdi
	call	putchar@plt # )

	.disp_exit:
	leaq	NIL(%rip), %rdi
	movq	%rdi, 8(%rsp) # Return NIL
	ret
