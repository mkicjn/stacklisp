# These are pseudo-functions to be caught by rpn and converted to bytecode flags
.type	cond, @function #|cond|
cond:
	ret
.type	progn, @function #|progn|
progn:
	ret
.type	quote, @function #|quote|
quote:
	ret
.type	return, @function #|return|
return:
	ret
