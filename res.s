.text
.globl f
	 .type f, @function

	##    Function      ##
f:
	# f (varcount 2, parmcount 0)
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	ADDQ $412, %rdi
	MOVQ %rdi, %r10
	ADDQ %rsi, %r10
	ADDQ $33, %r10
	ADDQ $7, %r10
	MOVQ %r10, %rax
	leave 			# leave function  
	ret
