# These are pseudo-functions to be caught by rpn and converted to bytecode flags
.type	cond, @function
cond:
	ret
.type	progn, @function
progn:
	ret
.type	quote, @function
quote:
	ret
.type	return, @function
return:
	ret
