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
