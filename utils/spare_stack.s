.data
spare_stack:
	.quad	1 # Offset for next open quadword
	.space	256 # May need to be increased in the future
.text

.type	sspush_a_c, @function
sspush_a_c: # Unique calling convention. Arguments in %rax and %rcx
	# Preserves all registers except %r8 and %r9
	leaq	spare_stack(%rip), %r8
	movq	(%r8), %r9 # Offset
	movq	%rax, (%r8,%r9,8)
	incq	%r9
	movq	%rcx, (%r8,%r9,8)
	incq	%r9
	movq	%r9, (%r8)
	ret

.type	sspop_a_c, @function
sspop_a_c: # Unique calling convention. Return values in %rax and %rcx
	# Preserves all registers except %r8 and %r9
	leaq	spare_stack(%rip), %r8
	movq	(%r8), %r9
	decq	%r9
	movq	(%r8,%r9,8), %rcx
	decq	%r9
	movq	(%r8,%r9,8), %rax
	movq	%r9, (%r8)
	ret

.type	sspush, @function
sspush_di: # Standard calling convention.
	# Preserves all registers except %r8 and %r9
	leaq	spare_stack(%rip), %r8
	movq	(%r8), %r9
	movq	%rdi, (%r8,%r9,8)
	incq	(%r8)
	ret

.type	sspop, @function
sspop_di: # Unique calling convention. Return value in %rdi
	leaq	spare_stack(%rip), %r8
	decq	(%r8)
	movq	(%r8), %r9
	movq	(%r8,%r9,8), %rdi
	ret

.type	sspush_10, @function
sspush_10: # Unique calling convention. Argument in %r10
	# Preserves all registers except %r8 and %r9
	leaq	spare_stack(%rip), %r8
	movq	(%r8), %r9
	movq	%r10, (%r8,%r9,8)
	incq	(%r8)
	ret

.type	sspop_10, @function
sspop_10: # Unique calling convention. Return value in %r10
	leaq	spare_stack(%rip), %r8
	decq	(%r8)
	movq	(%r8), %r9
	movq	(%r8,%r9,8), %r10
	ret

.type	sspush_env, @function
sspush_env:
	movq	ENV(%rip), %rdi
	call	sspush_di
	ret

.type	sspop_env, @function
sspop_env:
	call	sspop_di
	leaq	ENV(%rip), %rax
	movq	%rdi, (%rax)
	ret
