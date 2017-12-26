# Original: (defun rpn (l) (if (atom l) (cons l nil) (nconc (maprpn (cdr l)) (rpn (car l)))))
.type	rpn, @function
rpn:
	movq	8(%rsp), %rax
	cmpq	$0, %rax
	jz	.rpn_atom
	cmpq	$0, (%rax)
	jnz	.rpn_atom
	pushq	%rax
	pushq	%rax
	pushq	%rax
	call	cdr
	call	swap
	call	car
	call	reference
	popq	%rax
	cmpq	$4, (%rax)
	jne	.rpn_unspecial
	pushq	$0
	call	swap
	call	cons
	.rpn_unspecial:
	call	maprpn
	call	swap
	call	car
	call	rpn
	call	nconc
	jmp	.rpn_ret
	.rpn_atom:
	pushq	%rax
	leaq	NIL(%rip), %rax
	pushq	%rax
	call	cons
	.rpn_ret:
	popq	8(%rsp)
	ret

# Original: (defun maprpn (l) (if (atom l) l (nconc (rpn (car l)) (maprpn (cdr l)))))
.type	maprpn, @function
maprpn:
	movq	8(%rsp), %rax
	cmpq	$0, %rax
	jz	.maprpn_atom
	cmpq	$0, (%rax)
	jnz	.maprpn_atom
	pushq	%rax
	pushq	%rax
	call	car
	call	rpn
	call	swap
	call	cdr
	call	maprpn
	call	nconc
	popq	8(%rsp)
	.maprpn_atom:
	ret
