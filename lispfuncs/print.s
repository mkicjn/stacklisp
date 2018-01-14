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

.type	print, @function #|print|
print:
	movq	8(%rsp), %rdi
	cmpq	$0xff, %rdi
	jle	.print_flag
	cmpq	NILptr(%rip), %rdi
	je	.print_nil
	cmpq	$0, (%rdi)
	jz	.print_cell
	jl	.print_func
	cmpq	$1, (%rdi)
	je	.print_sym
	cmpq	$2, (%rdi)
	je	.print_num
	cmpq	$3, (%rdi)
	je	.print_func
	cmpq	$4, (%rdi)
	je	.print_dub
	jmp	.print_exit # Unknown datatype
	.print_flag:
	call	print_flag
	jmp	.print_exit
	.print_nil:
	leaq	NILstr(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.print_exit
	.print_sym:
	movq	8(%rdi), %rsi
	leaq	fstr(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.print_exit
	.print_num:
	movq	8(%rdi), %rsi
	leaq	fnum(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.print_exit
	.print_func:
	leaq	ffun(%rip), %rdi
	xorq	%rax, %rax
	call	printf@plt
	jmp	.print_exit
	.print_dub:
	movsd	16(%rdi), %xmm0
	leaq	fdub(%rip), %rdi
	movl	$1, %eax
	call	printf@plt
	jmp	.print_exit
	.print_cell:
	movl	$40, %edi
	call	putchar@plt # (

	pushq	8(%rsp) # Push the cell to the stack
	.print_cell_l:
	call	dup # Duplicate the list
	call	car # Replace duplicate with head
	call	print # Print the head (and drop from stack)
	call	drop

	movl	$32, %edi
	call	putchar@plt # space

	call	cdr # Get the cell's tail
	movq	(%rsp), %rdi
	cmpq	NILptr(%rip), %rdi
	jz	.print_cell_lx 
	movq	(%rsp), %rdi
	cmpq	$0xff, %rdi # Is the tail a flag?
	jle	.print_cell_pd # Don't check type
	cmpq	$0, (%rdi) # Is tail another list?
	jz	.print_cell_l

	.print_cell_pd:
	# Tail must be a non-nil atom
	movq	$46, %rdi # .
	call	putchar@plt
	movq	$32, %rdi # space
	call	putchar@plt

	#pushq	(%rsp) # LAZY HACK: Dupe so print_cell_lx has something to remove
	call	print

	movq	$32, %rdi # space
	call	putchar@plt

	.print_cell_lx: # Done printing list
	popq	%rdi # Drop top stack item
	movl	$8, %edi
	call	putchar@plt # backspace (LAZY HACK)
	movl	$41, %edi
	call	putchar@plt # )

	.print_exit:
	leaq	NIL(%rip), %rdi
	movq	%rdi, 8(%rsp) # Return NIL
	ret
