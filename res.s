.text
.globl f
	 .type f, @function

	##    Function      ##
f:
	# f (varcount 2, parmcount 0)
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	MOVQ %rdi, %rax
	MULQ %rsi
	MOVQ %rax, %rax
	MULQ %rsi
	 NEGQ %rax
	ADDQ %rax, %rsi
	 NEGQ %rsi
	MOVQ %rsi, %rax
	MULQ %rdi
	#value is already in rax
	leave 			# leave function  
	ret
