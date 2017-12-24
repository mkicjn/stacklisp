cell_str:
	.string	"CELL"
symbol_str
	.string	"SYMBOL"
number_str:
	.string	"NUMBER"

.type	type, @function
type: # Stack-based
	movq	8(%rsp), %rax
	cmpq	$0, (%rax)
	jz	.type_cell
	cmpq	$0, (%rax)
	jz	.type_symbol
	cmpq	$0, (%rax)
	jz	.type_number
	jmp	.type_ret
	.type_cell:
	leaq	cell_str(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	jmp	.type_ret
	.type_symbol:
	leaq	symbol_str(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	jmp	.type_ret
	.type_number:
	leaq	number_str(%rip), %rdi
	movq	$1, %rsi
	call	new_var
	.type_ret:
	movq	%rax, 8(%rsp)
	ret
# A new symbol is made each time to avoid modifying read-only data
