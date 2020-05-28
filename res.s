#--!root[0], line 0 @0  Type: (0) addr: 0x7fffef77e730
	#--f[0], line 1 @0  Funcdef (parmcount: 2) addr: 0x7fffef77d1d0
		#--a[0], line 1 @1  Type: (9) addr: 0x7fffef77d310
		#--b[1], line 1 @2  Type: (9) addr: 0x7fffef77d570
		#--!Assignment[2], line 0 @0  Type: (4) addr: 0x7fffef77db50
			#--b[0], line 10 @0  Type: (0) addr: 0x7fffef77d6b0
		#--!Assignment[3], line 0 @0  Type: (4) addr: 0x7fffef77de70
		#--!Return[4], line 0 @0  Type: (7) addr: 0x7fffef77e050
.text
.globl f
	 .type f, @function
f: ##    Function     (no. of params: 2, declared vars: 0) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx

	movq $64, %rax
	addq %rdi, %rax
	movq %rax, %rsi
	pushq %rax
	movq $1000, %rax
	popq %rbx
	movq %rax, (%rbx)
	movq $0, %rax
	POPQ %rbx
	leave 			# leave function  
	ret
