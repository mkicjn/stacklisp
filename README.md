# stacklisp
A stack-based bytecode compiler/interpreter for a simple LISP dialect

This program translates Lisp's nested list structure into Forth style reverse Polish notation syntax, and then compiles that structure into a simple bytecode for easy interpretation.

At the time of this writing, I am a college freshman going into computer engineering, but I haven't yet taken any computer science classes at my university (and won't until Fall 2018), so I apologize in advance if sections of the code are amateurish or my terminology is incorrect. All of my knowledge of assembly is self-taught, and this is only my second assembly project.

Nevertheless, this project is under active development and will see many more features in the coming months as I work around my college schedule.

### Notes on usage:
* The compiled executable from repl.s will (obviously) act as a REPL when executed with no arguments, but can execute a source code file as a script if provided as an argument. The script's return value will not be displayed by the executable.
* Errors are not handled consistently, but are most often ignored. This can be considered a flaw. Most erroneous forms will return NIL, or have invalid arguments ignored in the case of arithmetic functions. (For `+` and `-`, non-numbers are 0. For `*` and `/`, non-numbers are 1.) Complete forms with unbalanced parentheses will be identified by infer_type as an error and the reader will ultimately return NIL. Calling NIL as a function (directly or by calling an undefined variable's definition) has no error handling (i.e. causes a segfault) to avoid conflicting with real functions that are supposed to return NIL.
* The only "special forms" are `cond`, `progn`, and `quote`. The RPN translator translates them differently. Every other function is treated identically.
* Nothing is implicit. There are no implicit `quote`s or `progn`s. This allows for code generation possibilities that I think may make macros unnecessary. **Example(s) to come.**
* The function `funcall` is of limited availability to the programmer. Indirect calls to `funcall` will likely segfault. Direct calls to it are internally ignored by the translator, which will act as though `funcall` is not present at the head of the list. Objects at the beginning of evaluated forms are always called as functions. If you absolutely must have an equivalent for some reason, you could do something along the lines of `(lambda '(f x y) '(f x y))`. The actual funcall, implemented in assembly, may become nonexistent to the environment as a whole in the future. That, or it will become internal and a new `funcall` will appear as a variadic function.
* The assembly function eval is functionally equivalent to `(lambda '(f) '((lambda nil f)))`.

To list all LISP functions, do `cat lispfuncs/*.s | grep @function | sed 's/^.type.*@function #|\(.*\)|$/\1/'`

### Upcoming features, in order of priority:
* More mathematics
	- Inequalities (greater/less than)
	- Complex mathematical functions (expt, exp, sin, etc.)
* Better memory management (resizeable spare stack / garbage collection)
	- Complete elimination of the spare stack if possible
* A tagbody or prog equivalent (to allow for avoiding recursion)
* A Forth-like embedded syntax (with a faster and simpler bytecode interpreter)
  - Lower-level stack manipulations and facilities to implement new variadic functions without `list`
* Strings (stored the same as symbols but read differently)
	- Different functions available to strings (split, join, etc.)
* Consider restructuring special forms (specifically `cond`) for efficiency
