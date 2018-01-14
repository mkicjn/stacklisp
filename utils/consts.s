NILstr:
	.string "NIL"
NIL:
	.quad	1,NILstr,NIL
NILptr:
	.quad	NIL

Tstr:
	.string	"T"
T:
	.quad	1,Tstr,0
Tptr:
	.quad	T
