((lambda nil '(progn (define 'i (read 1024)) (cond ((eq i 'quit) t) (t (progn (disp (eval i)) (terpri) (terpri) (@)))))))
