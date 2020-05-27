#--!root[0], line 0 @0  Type: (0) addr: 0x7fffc7e2f1b0
	#--f[0], line 1 @0  Funcdef (parmcount: 2) addr: 0x7fffc7e2d1d0
		#--a[0], line 1 @1  Type: (9) addr: 0x7fffc7e2d310
		#--b[1], line 1 @2  Type: (9) addr: 0x7fffc7e2d570
		#--s[2], line 10 @0  Type: (12) addr: 0x7fffc7e2d6b0
		#--!If[3], line 0 @0  Type: (3) addr: 0x7fffc7e2e8d0
			#--!Statements[0], line 0 @0  Type: (2) addr: 0x7fffc7e2e4f0
				#--!Return[0], line 0 @0  Type: (7) addr: 0x7fffc7e2dc70
			#--!Statements[1], line 0 @0  Type: (2) addr: 0x7fffc7e2e110
				#--!Return[0], line 0 @0  Type: (7) addr: 0x7fffc7e2de50
		#--!Return[4], line 0 @0  Type: (7) addr: 0x7fffc7e2e050
.text
.globl f
	 .type f, @function
f: ##    Function     (no. of params: 2, declared vars: 1) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx
	SUBQ $8, %rsp 		# reserve space for 1 vars

	movq $1, -8(%rbp)
	movq $-1, %rax
	test $1, %rax
	jz __LAB1 
	movq $1, %rax
	POPQ %rbx
	leave 			# leave function  
	ret
	jmp __LAB0
__LAB1:
	movq $2, %rax
	POPQ %rbx
	leave 			# leave function  
	ret
__LAB0:
	movq -8(%rbp), %rax
	POPQ %rbx
	leave 			# leave function  
	ret
