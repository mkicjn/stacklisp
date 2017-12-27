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
freturn: # 0xee
	.string "{RETURN}"
fbad:
	.string "{BAD}"

.type	disp_flag, @function
disp_flag: # Standard calling convention
	pushq	%rdi
	cmpq	$0x0, %rdi
	jz	.disp_flag_null
	cmpq	$0xa1, %rdi
	je	.disp_flag_pushq
	cmpq	$0xaa, %rdi
	je	.disp_flag_pusharg
	cmpq	$0xc0, %rdi
	je	.disp_flag_cond
	cmpq	$0xc1, %rdi
	je	.disp_flag_case
	cmpq	$0xc2, %rdi
	je	.disp_flag_case_end
	cmpq	$0xc3, %rdi
	je	.disp_flag_cond_end
	cmpq	$0xca, %rdi
	je	.disp_flag_call
	cmpq	$0xee, %rdi
	je	.disp_flag_return
	leaq	fbad(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_null:
	leaq	fnull(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_pushq:
	leaq	fpushq(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_pusharg:
	leaq	fpusharg(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_cond:
	leaq	fcond(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_case:
	leaq	fcase(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_case_end:
	leaq	fcase_end(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_cond_end:
	leaq	fcond_end(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_call:
	leaq	fcall(%rip), %rdi
	jmp	.disp_flag_printf
	.disp_flag_return:
	leaq	freturn(%rip), %rdi
	.disp_flag_printf:
	xorq	%rax, %rax
	call	printf@plt
	popq	%rdi
	ret
