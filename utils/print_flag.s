fnull: # 0x0
	.string "{NULL}"
fpushq: # 0xa1
	.string	"{PUSH}"
fpusharg: # 0xaa
	.string "{PUSH_ARG}"
fcond: # 0xc0
	.string "{COND}"
fcase: # 0xc1
	.string "{CASE}"
fcase_end: # 0xc2
	.string "{CASE_END}"
fcond_end: # 0xc3
	.string "{COND_END}"
fcall: # 0xca
	.string "{CALL}"
fdrop: # 0xdd
	.string "{DROP}"
freturn: # 0xee
	.string "{RETURN}"
fother:
	.string "{0x%X}"

.type	print_flag, @function
print_flag: # Standard calling convention
	pushq	%rdi
	cmpq	$0x0, %rdi
	jz	.print_flag_null
	cmpq	$0xa1, %rdi
	je	.print_flag_pushq
	cmpq	$0xaa, %rdi
	je	.print_flag_pusharg
	cmpq	$0xc0, %rdi
	je	.print_flag_cond
	cmpq	$0xc1, %rdi
	je	.print_flag_case
	cmpq	$0xc2, %rdi
	je	.print_flag_case_end
	cmpq	$0xc3, %rdi
	je	.print_flag_cond_end
	cmpq	$0xca, %rdi
	je	.print_flag_call
	cmpq	$0xdd, %rdi
	je	.print_flag_drop
	cmpq	$0xee, %rdi
	je	.print_flag_return
	movq	%rdi, %rsi
	leaq	fother(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_null:
	leaq	fnull(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_pushq:
	leaq	fpushq(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_pusharg:
	leaq	fpusharg(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_cond:
	leaq	fcond(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_case:
	leaq	fcase(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_case_end:
	leaq	fcase_end(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_cond_end:
	leaq	fcond_end(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_call:
	leaq	fcall(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_drop:
	leaq	fdrop(%rip), %rdi
	jmp	.print_flag_printf
	.print_flag_return:
	leaq	freturn(%rip), %rdi
	.print_flag_printf:
	xorq	%rax, %rax
	call	printf@plt
	popq	%rdi
	ret
