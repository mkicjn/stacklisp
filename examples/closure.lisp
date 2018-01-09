(progn
  (load 'examples/functions.lisp)
  (declare 'closure (lambda '(MEMBERS) '(lambda MEMBERS (nsplice (list '(progn) ((lambda '(m) '(cond (m (cons (list 'define (quotation (car m)) (car m)) (@ (cdr m)))))) MEMBERS) (cons (list 'lambda '(quote (OBJ_MEMB)) (quotation (cons 'cond ((lambda '(m) '(cond (m (cons (list (list 'eq 'OBJ_MEMB (quotation (car m))) (car m)) (@ (cdr m)))))) MEMBERS)))) nil))))))
  t)
