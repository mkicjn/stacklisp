.include "inclusions.s"

.globl	main
.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp

	call	seed_rng
	.repl:
	movq	$1024, %rdi
	call	read_bytes
	pushq	%rax
	call	eval
	call	disp
	call	drop
	call	scc_terpri
	call	scc_terpri
	jmp	.repl

	leave
	ret
