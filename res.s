#--!root[0], line 0 @0  Type: (0) addr: 0x7fffcb8dd710
	#--f[0], line 1 @0  Funcdef (parmcount: 2) addr: 0x7fffcb8d71d0
		#--a[0], line 1 @1  Type: (9) addr: 0x7fffcb8d7310
		#--b[1], line 1 @2  Type: (9) addr: 0x7fffcb8d7570
		#--x0[2], line 3 @0  Type: (12) addr: 0x7fffcb8d76b0
		#--x1[3], line 4 @0  Type: (12) addr: 0x7fffcb8d7910
		#--fib[4], line 5 @0   (LOOP)  addr: 0x7fffcb8d7b70
			#--!If[0], line 0 @0  Type: (3) addr: 0x7fffcb8d9d30
				#--!Statements[0], line 0 @0  Type: (2) addr: 0x7fffcb8d9950
					#--tmp[0], line 7 @0  Type: (12) addr: 0x7fffcb8d7f30
					#--!Assignment[1], line 0 @0  Type: (4) addr: 0x7fffcb8d8550
						#--x1[0], line 8 @0  Type: (0) addr: 0x7fffcb8d81b0
					#--!Assignment[2], line 0 @0  Type: (4) addr: 0x7fffcb8d8890
						#--x0[0], line 9 @0  Type: (0) addr: 0x7fffcb8d8630
					#--!Assignment[3], line 0 @0  Type: (4) addr: 0x7fffcb8d8e10
						#--a[0], line 10 @0  Type: (0) addr: 0x7fffcb8d8970
				#--!Statements[1], line 0 @0  Type: (2) addr: 0x7fffcb8d9330
					#--s[0], line 12 @0  Type: (12) addr: 0x7fffcb8d8ef0
					#--!Loopref[1], line 0 @0  Type: (5) addr: 0x7fffcb8d9270
						#--fib[0], line 13 @0  Type: (0) addr: 0x7fffcb8d9150
		#--last[5], line 16 @0  Type: (12) addr: 0x7fffcb8daa10
		#--!Return[6], line 0 @0  Type: (7) addr: 0x7fffcb8daed0
	#--g[1], line 20 @0  Funcdef (parmcount: 2) addr: 0x7fffcb8dafb0
		#--a[0], line 20 @1  Type: (9) addr: 0x7fffcb8db0f0
		#--b[1], line 20 @2  Type: (9) addr: 0x7fffcb8db350
		#--cur[2], line 22 @0  Type: (12) addr: 0x7fffcb8db490
		#--cnt[3], line 23 @0  Type: (12) addr: 0x7fffcb8db710
		#--rest[4], line 24 @0  Type: (12) addr: 0x7fffcb8db970
		#--div[5], line 25 @0   (LOOP)  addr: 0x7fffcb8dbbd0
			#--!Assignment[0], line 0 @0  Type: (4) addr: 0x7fffcb8dbf70
				#--rest[0], line 26 @0  Type: (0) addr: 0x7fffcb8dbd10
			#--!Assignment[1], line 0 @0  Type: (4) addr: 0x7fffcb8dc510
				#--cur[0], line 27 @0  Type: (0) addr: 0x7fffcb8dc050
			#--!If[2], line 0 @0  Type: (3) addr: 0x7fffcb8e0890
				#--!Statements[0], line 0 @0  Type: (2) addr: 0x7fffcb8e04b0
					#--!Assignment[0], line 0 @0  Type: (4) addr: 0x7fffcb8ddaf0
						#--cnt[0], line 29 @0  Type: (0) addr: 0x7fffcb8dc870
				#--!Statements[1], line 0 @0  Type: (2) addr: 0x7fffcb8e00d0
					#--!Loopref[0], line 0 @0  Type: (5) addr: 0x7fffcb8ddcf0
						#--div[0], line 31 @0  Type: (0) addr: 0x7fffcb8ddbd0
		#--!Return[6], line 0 @0  Type: (7) addr: 0x7fffcb8ddef0
	#--isPrime[2], line 38 @0  Funcdef (parmcount: 1) addr: 0x7fffcb8ddfd0
		#--a[0], line 38 @1  Type: (9) addr: 0x7fffcb8de110
		#--loopCount[1], line 41 @0  Type: (12) addr: 0x7fffcb8de370
		#--checkPrime[2], line 42 @0   (LOOP)  addr: 0x7fffcb8de5d0
			#--!If[0], line 0 @0  Type: (3) addr: 0x7fffcb8e61d0
				#--!Statements[0], line 0 @0  Type: (2) addr: 0x7fffcb8df6d0
					#--rest[0], line 46 @0  Type: (12) addr: 0x7fffcb8debf0
					#--cur[1], line 47 @0  Type: (12) addr: 0x7fffcb8dee50
					#--cnt[2], line 48 @0  Type: (12) addr: 0x7fffcb8df0d0
					#--div1[3], line 49 @0   (LOOP)  addr: 0x7fffcb8df330
						#--!Assignment[0], line 0 @0  Type: (4) addr: 0x7fffcb8e0d90
							#--rest[0], line 50 @0  Type: (0) addr: 0x7fffcb8df470
						#--!Assignment[1], line 0 @0  Type: (4) addr: 0x7fffcb8e1330
							#--cur[0], line 51 @0  Type: (0) addr: 0x7fffcb8e0e70
						#--!Statements[2], line 0 @0  Type: (2) addr: 0x7fffcb8e28d0
							#--!Loopref[0], line 0 @0  Type: (5) addr: 0x7fffcb8e1a10
								#--div1[0], line 53 @0  Type: (0) addr: 0x7fffcb8e18f0
					#--!Statements[4], line 0 @0  Type: (2) addr: 0x7fffcb8e2190
						#--!Return[0], line 0 @0  Type: (7) addr: 0x7fffcb8e20d0
					#--!Assignment[5], line 0 @0  Type: (4) addr: 0x7fffcb8e38b0
						#--loopCount[0], line 60 @0  Type: (0) addr: 0x7fffcb8e3530
				#--!Statements[1], line 0 @0  Type: (2) addr: 0x7fffcb8e5cd0
					#--!Return[0], line 0 @0  Type: (7) addr: 0x7fffcb8e3a90
	#--divwithrest[3], line 67 @0  Funcdef (parmcount: 3) addr: 0x7fffcb8e3b70
		#--a[0], line 67 @1  Type: (9) addr: 0x7fffcb8e3cb0
		#--b[1], line 67 @2  Type: (9) addr: 0x7fffcb8e3f10
		#--lrest[2], line 67 @3  Type: (9) addr: 0x7fffcb8e4050
		#--cur[3], line 69 @0  Type: (12) addr: 0x7fffcb8e4190
		#--cnt[4], line 70 @0  Type: (12) addr: 0x7fffcb8e4410
		#--rest[5], line 71 @0  Type: (12) addr: 0x7fffcb8e4670
		#--divrest[6], line 72 @0   (LOOP)  addr: 0x7fffcb8e48d0
			#--!Assignment[0], line 0 @0  Type: (4) addr: 0x7fffcb8e4c70
				#--rest[0], line 73 @0  Type: (0) addr: 0x7fffcb8e4a10
			#--!Assignment[1], line 0 @0  Type: (4) addr: 0x7fffcb8e5210
				#--cur[0], line 74 @0  Type: (0) addr: 0x7fffcb8e4d50
			#--!If[2], line 0 @0  Type: (3) addr: 0x7fffcb8e83d0
				#--!Statements[0], line 0 @0  Type: (2) addr: 0x7fffcb8e7ff0
					#--!Assignment[0], line 0 @0  Type: (4) addr: 0x7fffcb8e6e90
						#--cnt[0], line 76 @0  Type: (0) addr: 0x7fffcb8e6b10
				#--!Statements[1], line 0 @0  Type: (2) addr: 0x7fffcb8e7c10
					#--!Loopref[0], line 0 @0  Type: (5) addr: 0x7fffcb8e7090
						#--divrest[0], line 78 @0  Type: (0) addr: 0x7fffcb8e6f70
		#--!Assignment[7], line 0 @0  Type: (4) addr: 0x7fffcb8e73d0
		#--!Assignment[8], line 0 @0  Type: (4) addr: 0x7fffcb8e7830
		#--!Return[9], line 0 @0  Type: (7) addr: 0x7fffcb8e7a30
.text
.globl f
	 .type f, @function
.globl g
	 .type g, @function
.globl isPrime
	 .type isPrime, @function
.globl divwithrest
	 .type divwithrest, @function
f: ##    Function     (no. of params: 2, declared vars: 4) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx
	SUBQ $32, %rsp 		# reserve space for 4 vars

	movq $0, -8(%rbp)
	movq $1, -16(%rbp)
__fib:
	cmp $0, %rdi
	je __LAB7
	MOVQ $-1, %rax
	jmp __LAB8
	__LAB7:
	MOVQ $0, %rax
	__LAB8:
	test $1, %rax
	jz __LAB6 
	movq -16(%rbp), %rax
	movq %rax, -24(%rbp)
# binop called lhs: -8(%rbp) (ADDQ) rhs: -16(%rbp)
	movq -8(%rbp), %rax
	ADDQ -16(%rbp), %rax
# end binop
	movq %rax, -16(%rbp)
	movq -24(%rbp), %rax
	movq %rax, -8(%rbp)
	movq $-1, %rax
	addq %rdi, %rax
	movq %rax, %rdi
	jmp __LAB0
__LAB6:
	movq $3, -24(%rbp)
	jmp __endfib
__LAB0:
	jmp __fib # loops 
 __endfib:
	movq $300, -32(%rbp)
# binop called lhs: -16(%rbp) (ADDQ) rhs: -32(%rbp)
	movq -16(%rbp), %rax
	ADDQ -32(%rbp), %rax
# end binop
	POPQ %rbx
	leave 			# leave function  
	ret
g: ##    Function     (no. of params: 2, declared vars: 3) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx
	SUBQ $24, %rsp 		# reserve space for 3 vars

	movq %rdi, -8(%rbp)
	movq $0, -16(%rbp)
	movq $0, -24(%rbp)
__div:
	movq -8(%rbp), %rax
	movq %rax, -24(%rbp)
	movq %rsi, %rax
	NEGQ %rax
# binop called lhs: -8(%rbp) (ADDQ) rhs: rax
	movq -8(%rbp), %rbx
	ADDQ %rax, %rbx
# end binop
	movq %rbx, -8(%rbp)
	movq -8(%rbp), %rbx
	cmp $0, %rbx
	jl __LAB10
	MOVQ $-1, %rax
	jmp __LAB11
	__LAB10:
	MOVQ $0, %rax
	__LAB11:
	test $1, %rax
	jz __LAB9 
	movq $1, %rax
	addq -16(%rbp), %rax
	movq %rax, -16(%rbp)
	jmp __LAB1
__LAB9:
	jmp __enddiv
__LAB1:
	jmp __div # loops 
 __enddiv:
	movq -16(%rbp), %rax
	POPQ %rbx
	leave 			# leave function  
	ret
isPrime: ##    Function     (no. of params: 1, declared vars: 4) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx
	SUBQ $32, %rsp 		# reserve space for 4 vars

	movq $2, -8(%rbp)
__checkPrime:
	movq $-1, %rax
	addq %rdi, %rax
	movq -8(%rbp), %r10
	cmp %rax, %r10
	jg __LAB13
	MOVQ $-1, %rbx
	jmp __LAB14
	__LAB13:
	MOVQ $0, %rbx
	__LAB14:
	movq %rbx, %rax
	test $1, %rax
	jz __LAB12 
	movq $0, -16(%rbp)
	movq %rdi, -24(%rbp)
	movq $0, -32(%rbp)
__div1:
	movq -24(%rbp), %rax
	movq %rax, -16(%rbp)
	movq -8(%rbp), %rax
	NEGQ %rax
# binop called lhs: -24(%rbp) (ADDQ) rhs: rax
	movq -24(%rbp), %rbx
	ADDQ %rax, %rbx
# end binop
	movq %rbx, -24(%rbp)
	movq -24(%rbp), %rbx
	cmp $0, %rbx
	jg __LAB15
	MOVQ $-1, %rax
	jmp __LAB16
	__LAB15:
	MOVQ $0, %rax
	__LAB16:
	movq -24(%rbp), %r10
	cmp $0, %r10
	je __LAB17
	MOVQ $-1, %rbx
	jmp __LAB18
	__LAB17:
	MOVQ $0, %rbx
	__LAB18:
# binop called lhs: rax (ANDQ) rhs: rbx
	movq %rax, %r10
	ANDQ %rbx, %r10
# end binop
	movq %r10, %rax
	test $1, %rax
	jz __LAB3
	jmp __enddiv1
__LAB3:
	jmp __div1 # loops 
 __enddiv1:
	movq -16(%rbp), %rbx
	cmp $0, %rbx
	jg __LAB19
	MOVQ $-1, %rax
	jmp __LAB20
	__LAB19:
	MOVQ $0, %rax
	__LAB20:
	movq -16(%rbp), %r10
	cmp $0, %r10
	jl __LAB21
	MOVQ $-1, %rbx
	jmp __LAB22
	__LAB21:
	MOVQ $0, %rbx
	__LAB22:
# binop called lhs: rax (ANDQ) rhs: rbx
	movq %rax, %r10
	ANDQ %rbx, %r10
# end binop
	movq %r10, %rax
	test $1, %rax
	jz __LAB4
	movq $0, %rax
	POPQ %rbx
	leave 			# leave function  
	ret
__LAB4:
	movq $1, %rax
	addq -8(%rbp), %rax
	movq %rax, -8(%rbp)
	jmp __LAB2
__LAB12:
	movq $1, %rax
	POPQ %rbx
	leave 			# leave function  
	ret
__LAB2:
	jmp __checkPrime # loops 
 __endcheckPrime:
divwithrest: ##    Function     (no. of params: 3, declared vars: 3) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx
	SUBQ $24, %rsp 		# reserve space for 3 vars

	movq %rdi, -8(%rbp)
	movq $0, -16(%rbp)
	movq $0, -24(%rbp)
__divrest:
	movq -8(%rbp), %rax
	movq %rax, -24(%rbp)
	movq %rsi, %rax
	NEGQ %rax
# binop called lhs: -8(%rbp) (ADDQ) rhs: rax
	movq -8(%rbp), %rbx
	ADDQ %rax, %rbx
# end binop
	movq %rbx, -8(%rbp)
	movq -8(%rbp), %rbx
	cmp $0, %rbx
	jl __LAB24
	MOVQ $-1, %rax
	jmp __LAB25
	__LAB24:
	MOVQ $0, %rax
	__LAB25:
	test $1, %rax
	jz __LAB23 
	movq $1, %rax
	addq -16(%rbp), %rax
	movq %rax, -16(%rbp)
	jmp __LAB5
__LAB23:
	jmp __enddivrest
__LAB5:
	jmp __divrest # loops 
 __enddivrest:
	movq %rdx, %rax
	pushq %rax
	movq -24(%rbp), %rax
	popq %rbx
	movq %rax, (%rbx)
	movq $8, %rax
	addq %rdx, %rax
	pushq %rax
	movq -24(%rbp), %rax
	popq %rbx
	movq %rax, (%rbx)
	movq -16(%rbp), %rax
	POPQ %rbx
	leave 			# leave function  
	ret
