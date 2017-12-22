# (defun rpn (l) (if (atom l) (cons l nil) (nconc (maprpn (cdr l)) (rpn (car l)))))
.type	rpn, @function
rpn:
	ret

# (defun maprpn (l) (if (atom l) l (nconc (rpn (car l)) (maprpn (cdr l)))))
.type	maprpn, @function
maprpn:
	ret
