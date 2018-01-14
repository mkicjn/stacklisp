.type	zornil, @function
zornil: # Returns 1 to %rax if %rdi is 0 or NIL, 0 otherwise
	cmpq	$0, %rdi
	jz	.null_ret1
	leaq	NIL(%rip), %rax
	cmpq	%rax, %rdi
	je	.null_ret1
	xorq	%rax, %rax
	ret
.null_ret1:
	movl	$1, %eax
	ret
