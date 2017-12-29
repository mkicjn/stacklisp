.type	lambda_size, @function
lambda_size: # Standard calling convention. Predicts the size of the compiled body.
	call	scc_length
	leaq	16(,%rax,8), %rax # rax=16+rax*8
	ret
