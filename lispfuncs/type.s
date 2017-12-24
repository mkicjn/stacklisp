cell_str:
	.string	"CELL"
symbol_str:
	.string	"SYMBOL"
number_str:
	.string	"NUMBER"
function_str:
	.string	"FUNCTION"

.type	type, @function
type: # Stack-based
	movq	8(%rsp), %rax
	cmpq	$1, (%rax)
	jz	.type_symbol
	cmpq	$2, (%rax)
	jz	.type_number
	cmpq	$0, (%rax)
	jz	.type_cell
	jl	.type_function
	jmp	.type_ret
	.type_symbol:
	leaq	symbol_str(%rip), %rdi
	jmp	.type_ret
	.type_number:
	leaq	number_str(%rip), %rdi
	jmp	.type_ret
	.type_cell:
	leaq	cell_str(%rip), %rdi
	jmp	.type_ret
	.type_function:
	leaq	function_str(%rip), %rdi
	.type_ret:
	movq	$1, %rsi
	call	new_var
	movq	%rax, 8(%rsp)
	ret
# A new symbol is made each time to avoid modifying read-only data
