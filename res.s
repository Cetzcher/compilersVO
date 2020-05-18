.text
.globl f
	 .type f, @function

	##    Function      ##
f:
	# f (varcount 2, parmcount 0)
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	movq %rsi, %rax
	imulq $0, %rax
	movq %rdi, %rbx
	ADDQ %rax, %rbx
	movq %rbx, %rax
	leave 			# leave function  
	ret
