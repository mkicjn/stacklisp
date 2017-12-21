# (defun rpn (l) (cond ((null l) nil) ((atom l) (cons l nil)) (t (nconc (maprpn (cdr l)) (rpn (car l))))))
# (defun maprpn (l) (if l (nconc (rpn (car l)) (maprpn (cdr l))) nil))

# Recursion is easier with standard calling conventions (preserving registers)
# So, these will be written with standard calling conventions, with a helper function for argument on the stack

#
#	Something is broken in here at the moment
#

.type	scc_rpn, @function
scc_rpn:
	pushq	%rdi
	debug_disp
	call	zornil
	cmpq	$1, %rax
	leaq	NIL(%rip), %rax
	je	.scc_rpn_nil
	movq	(%rsp), %rdi # Recall form
	cmpq	$0, (%rdi) # Check if list
	jnz	.scc_rpn_atom
	popq	%rdi
	movq	16(%rdi), %rdi	# cdr
	call	maprpn
	pushq	%rax
	movq	8(%rsp), %rdi # Recall form
	movq	8(%rdi), %rdi # car
	call	scc_rpn
	pushq	%rax
	call	nconc
	popq	%rax
	ret
	.scc_rpn_atom:
	pushq	%rax # nil
	call	cons
	popq	%rax
	ret
	.scc_rpn_nil:
	popq	%rdi
	ret

.type	maprpn, @function
maprpn: # Standard calling convention. Never to be called on an atom (other than nil)
	pushq	%rdi
	call	zornil
	cmpq	$1, %rax
	je	.maprpn_nil
	movq	(%rsp), %rdi # Recall form
	movq	8(%rdi), %rdi # car
	call	scc_rpn
	pushq	%rax
	movq	8(%rsp), %rdi # Recall form
	movq	16(%rdi), %rdi # cdr
	call	maprpn
	pushq	%rax
	call	nconc
	popq	8(%rsp)
	popq	%rax
	ret
	.maprpn_nil:
	popq	%rdi
	leaq	NIL(%rip), %rax
	ret

.type	rpn, @function
rpn: # Stack-based helper function
	movq	8(%rsp), %rdi
	call	scc_rpn
	movq	%rax, 8(%rsp)
	ret
