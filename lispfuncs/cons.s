.type	cons, @function #|cons|
cons:
	movq	$24, %rdi
	call	malloc@plt
	popq	%rdi		# preserve return address
	movq	$0, (%rax)	# type = cell
	movq	8(%rsp), %rcx
	movq	%rcx, 8(%rax)	# car = arg1
	movq	(%rsp), %rcx
	movq	%rcx, 16(%rax)	# cdr = arg2
	movq	%rax, 8(%rsp)	# return cell (where arg1 was)
	movq	%rdi, (%rsp)	# restore return address (where arg2 was)
	ret
