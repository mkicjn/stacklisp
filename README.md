# stacklisp
A simple LISP compiler/interpreter with a stack-based twist

At the time of this writing, I am a college freshman going into computer engineering, but I haven't yet taken any computer science classes at my university, so I apologize in advance if sections of the code are amateurish or my terminology is incorrect. All of my knowledge of assembly is self-taught, and this is only my second assembly project.

This compiler translates Lisp's nested list structure into Forth style reverse Polish notation, and then compiles that structure into bytecode for easy interpretation.

For a simple REPL, compile and run evaluate.s and enter the following: `((lambda nil '(progn (disp (eval (read 200))) (terpri) (terpri) (@))))`

This will read 200 bytes of input each time. Notes on dialectical quirks coming soon, probably.
