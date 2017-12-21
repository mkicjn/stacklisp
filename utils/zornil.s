.type	zornil, @function
zornil: # Returns 1 to %rax if the top stack item is 0 or NIL, 0 otherwise
	cmpq	$0, 8(%rsp)
	jz	.null_ret1
	leaq	NIL(%rip), %rax
	cmpq	%rax, 8(%rsp)
	je	.null_ret1
	xorq	%rax, %rax
	ret
.null_ret1:
	movq	$1, %rax
	ret
