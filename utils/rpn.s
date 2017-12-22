# (defun rpn (l) (if (atom l) (cons l nil) (nconc (maprpn (cdr l)) (rpn (car l)))))
# With all maprpn as rpn, (rpn '(+ (- 2 (- 3 (+ 1 1))) 2)) => (NIL 2 NIL NIL NIL 1 1 + 3 - 2 - +)
# Under this condition, received (NIL 2 NIL NIL NIL 1 1 + 3 - 2 - +) -- SUCCESS!
.type	rpn, @function
rpn:
	movq	8(%rsp), %rax
	cmpq	$0, (%rax)
	jnz	.rpn_atom
	pushq	%rax
	pushq	%rax
	call	cdr
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
	popq	%rax
	movq	%rax, 8(%rsp)
	ret

# (defun maprpn (l) (if (atom l) l (nconc (rpn (car l)) (maprpn (cdr l)))))
# With all maprpn as rpn, (maprpn '(+ (- 2 (- 3 (+ 1 1))) 2)) => (+ NIL 2 NIL NIL NIL 1 1 + 3 - 2 -)
# Actually got (+ NIL 2 NIL NIL NIL 1 1 + 3 - 2 -) -- SUCCESS!
.type	maprpn, @function
maprpn:
	movq	8(%rsp), %rax
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
	popq	%rax
	movq	%rax, 8(%rsp)
	.maprpn_atom:
	ret
