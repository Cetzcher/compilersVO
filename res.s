.text
.globl f
	 .type f, @function

	##    Function      ##
f:
	# f (varcount 2, parmcount 0)
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	movq %rdi, %r10
	ADDQ %rsi, %r10
	ADDQ $5, %rdi
	movq %r10, %rax
	MULQ %rdi
	NEGQ %rax
	ADDQ $23, %rax
	ANDQ $4, %rax
	movq $7, %r11
	MULQ %r11
	ANDQ $24, %rax
	cmp $0, %rax
	jge __LAB0
	MOVQ $0, %r10
	jmp __LAB1
	__LAB0:
	MOVQ $-1, %r10
	__LAB1:
	movq %r10, %rax
	leave 			# leave function  
	ret
