.text
.globl f
	 .type f, @function
f: ##    Function     (no. of params: 2, declared vars: 0) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx

	movq %rdi, %rax
	imulq $2, %rax
	movq %rax, %rbx
	imulq $2, %rbx
	movq $3, %rax
	addq %rbx, %rax
	#value is already in rax
	POPQ %rbx
	leave 			# leave function  
	ret
