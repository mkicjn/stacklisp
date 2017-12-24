.type	copy, @function
copy: # Stack-based function (arg in 8(%rsp))
	movq	8(%rsp), %rdi
	call	var_copy
	movq	%rax, 8(%rsp)
	ret
