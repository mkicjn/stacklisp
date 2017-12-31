# (defun prep_cond_args (f) (if f (cons (nconc (cons '0xc2 (cons (caar f) nil)) (cons '0xc1 (cdar f))) (prep_cond_args (cdr f))) nil))
.type	prep_cond_args, @function
prep_cond_args: # Stack-based
	movq	8(%rsp), %rdi
	call	eqnil
	cmpq	$1, %rax
	je	.prep_cond_args_nil
	pushq	8(%rsp) # Push argument to stack
	call	dup
	# (cons '0xc2 (cons (caar f) nil))
	pushq	$0xc2
	call	swap
	call	car
	call	car
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	call	cons
	# (cons '0xc1 (cdar f))
	call	over
	pushq	$0xc1
	call	swap
	call	car
	call	cdr
	call	cons
	#
	call	nconc
	call	swap
	call	cdr
	call	prep_cond_args
	call	cons
	popq	8(%rsp) # Return value in location of argument
	.prep_cond_args_nil:
	ret

# (defun prep_cond (f) (nconc (cons 0xc0 nil) (prep_cond_args (cdr f)) (cons 0xc3 nil)))
.type	prep_cond, @function
prep_cond:
	pushq	$0xc0
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	pushq	16(%rsp)
	call	cdr
	call	prep_cond_args

	leaq	NIL(%rip), %rax
	pushq	%rax
	pushq	$0xc3
	pushq	%rax
	call	cons
	call	cons
	call	nconc
	call	nconc
	popq	8(%rsp)
	ret
