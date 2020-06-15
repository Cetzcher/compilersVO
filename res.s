#--!root[0], line 0 @0   Type: (0) addr: 0x7fffd9206010 Is linked? [NO]
	#--fib[0], line 1 @0  Funcdef (parmcount: 3) Type: (8) addr: 0x7fffd92021d0 Is linked? [NO]
		#--a[0], line 1 @1   Type: (9) addr: 0x7fffd9202310 Is linked? [NO]
		#--b[1], line 1 @2   Type: (9) addr: 0x7fffd9202570 Is linked? [NO]
		#--cnt[2], line 1 @3   Type: (9) addr: 0x7fffd92026b0 Is linked? [NO]
		#--!If[3], line 0 @0   Type: (3) addr: 0x7fffd9205730 Is linked? [NO]
			#--!Statements[0], line 0 @0   Type: (2) addr: 0x7fffd9205350 Is linked? [NO]
				#--!Return[0], line 0 @0   Type: (7) addr: 0x7fffd9202b90 Is linked? [NO]
			#--!Statements[1], line 0 @0   Type: (2) addr: 0x7fffd9204450 Is linked? [NO]
				#--!Return[0], line 0 @0   Type: (7) addr: 0x7fffd92034d0 Is linked? [NO]
	#--fib2[1], line 9 @0  Funcdef (parmcount: 2) Type: (8) addr: 0x7fffd92035b0 Is linked? [NO]
		#--a[0], line 9 @1   Type: (9) addr: 0x7fffd92036f0 Is linked? [NO]
		#--b[1], line 9 @2   Type: (9) addr: 0x7fffd9203950 Is linked? [NO]
		#--x0[2], line 11 @0   Type: (12) addr: 0x7fffd9203a90 Is linked? [NO]
		#--x1[3], line 12 @0   Type: (12) addr: 0x7fffd9203cf0 Is linked? [NO]
		#--fib3[4], line 13 @0   (LOOP)  Type: (1) addr: 0x7fffd9203f50 Is linked? [NO]
			#--!If[0], line 0 @0   Type: (3) addr: 0x7fffd9208b50 Is linked? [NO]
				#--!Statements[0], line 0 @0   Type: (2) addr: 0x7fffd9208770 Is linked? [NO]
					#--tmp[0], line 15 @0   Type: (12) addr: 0x7fffd9206690 Is linked? [NO]
					#--!Assignment[1], line 0 @0   Type: (4) addr: 0x7fffd9206cb0 Is linked? [NO]
						#--x1[0], line 16 @0   Type: (0) addr: 0x7fffd9206910 Is linked? [NO]
					#--!Assignment[2], line 0 @0   Type: (4) addr: 0x7fffd9206ff0 Is linked? [NO]
						#--x0[0], line 17 @0   Type: (0) addr: 0x7fffd9206d90 Is linked? [NO]
					#--!Assignment[3], line 0 @0   Type: (4) addr: 0x7fffd9207570 Is linked? [NO]
						#--a[0], line 18 @0   Type: (0) addr: 0x7fffd92070d0 Is linked? [NO]
				#--!Statements[1], line 0 @0   Type: (2) addr: 0x7fffd9208150 Is linked? [NO]
					#--s[0], line 20 @0   Type: (12) addr: 0x7fffd9207650 Is linked? [NO]
					#--!Loopref[1], line 0 @0   Type: (5) addr: 0x7fffd92079d0 Is linked? [NO]
						#--fib3[0], line 21 @0   Type: (0) addr: 0x7fffd92078b0 Is linked? [NO]
		#--last[5], line 24 @0   Type: (12) addr: 0x7fffd9207ab0 Is linked? [NO]
		#--!Return[6], line 0 @0   Type: (7) addr: 0x7fffd9207f70 Is linked? [NO]
	#--g[2], line 28 @0  Funcdef (parmcount: 2) Type: (8) addr: 0x7fffd9209450 Is linked? [NO]
		#--a[0], line 28 @1   Type: (9) addr: 0x7fffd9209590 Is linked? [NO]
		#--b[1], line 28 @2   Type: (9) addr: 0x7fffd92097f0 Is linked? [NO]
		#--cur[2], line 30 @0   Type: (12) addr: 0x7fffd9209930 Is linked? [NO]
		#--cnt[3], line 31 @0   Type: (12) addr: 0x7fffd9209bb0 Is linked? [NO]
		#--rest[4], line 32 @0   Type: (12) addr: 0x7fffd9209e10 Is linked? [NO]
		#--div[5], line 33 @0   (LOOP)  Type: (1) addr: 0x7fffd920a070 Is linked? [NO]
			#--!Assignment[0], line 0 @0   Type: (4) addr: 0x7fffd920a410 Is linked? [NO]
				#--rest[0], line 34 @0   Type: (0) addr: 0x7fffd920a1b0 Is linked? [NO]
			#--!Assignment[1], line 0 @0   Type: (4) addr: 0x7fffd920a9b0 Is linked? [NO]
				#--cur[0], line 35 @0   Type: (0) addr: 0x7fffd920a4f0 Is linked? [NO]
			#--!If[2], line 0 @0   Type: (3) addr: 0x7fffd920bc50 Is linked? [NO]
				#--!Statements[0], line 0 @0   Type: (2) addr: 0x7fffd920b870 Is linked? [NO]
					#--!Assignment[0], line 0 @0   Type: (4) addr: 0x7fffd920b090 Is linked? [NO]
						#--cnt[0], line 37 @0   Type: (0) addr: 0x7fffd920ad10 Is linked? [NO]
				#--!Statements[1], line 0 @0   Type: (2) addr: 0x7fffd920b490 Is linked? [NO]
					#--!Loopref[0], line 0 @0   Type: (5) addr: 0x7fffd920b290 Is linked? [NO]
						#--div[0], line 39 @0   Type: (0) addr: 0x7fffd920b170 Is linked? [NO]
		#--!Return[6], line 0 @0   Type: (7) addr: 0x7fffd920cb50 Is linked? [NO]
	#--isPrime[3], line 46 @0  Funcdef (parmcount: 1) Type: (8) addr: 0x7fffd920cc30 Is linked? [NO]
		#--a[0], line 46 @1   Type: (9) addr: 0x7fffd920cd70 Is linked? [NO]
		#--loopCount[1], line 49 @0   Type: (12) addr: 0x7fffd920cfd0 Is linked? [NO]
		#--checkPrime[2], line 50 @0   (LOOP)  Type: (1) addr: 0x7fffd920d230 Is linked? [NO]
			#--!If[0], line 0 @0   Type: (3) addr: 0x7fffd9214f50 Is linked? [NO]
				#--!Statements[0], line 0 @0   Type: (2) addr: 0x7fffd920edd0 Is linked? [NO]
					#--rest[0], line 54 @0   Type: (12) addr: 0x7fffd920d850 Is linked? [NO]
					#--cur[1], line 55 @0   Type: (12) addr: 0x7fffd920dab0 Is linked? [NO]
					#--cnt[2], line 56 @0   Type: (12) addr: 0x7fffd920dd30 Is linked? [NO]
					#--div1[3], line 57 @0   (LOOP)  Type: (1) addr: 0x7fffd920df90 Is linked? [NO]
						#--!Assignment[0], line 0 @0   Type: (4) addr: 0x7fffd920e330 Is linked? [NO]
							#--rest[0], line 58 @0   Type: (0) addr: 0x7fffd920e0d0 Is linked? [NO]
						#--!Assignment[1], line 0 @0   Type: (4) addr: 0x7fffd920f7d0 Is linked? [NO]
							#--cur[0], line 59 @0   Type: (0) addr: 0x7fffd920e410 Is linked? [NO]
						#--!Statements[2], line 0 @0   Type: (2) addr: 0x7fffd92114d0 Is linked? [NO]
							#--!Loopref[0], line 0 @0   Type: (5) addr: 0x7fffd920feb0 Is linked? [NO]
								#--div1[0], line 61 @0   Type: (0) addr: 0x7fffd920fd90 Is linked? [NO]
					#--!Statements[4], line 0 @0   Type: (2) addr: 0x7fffd9210d90 Is linked? [NO]
						#--!Return[0], line 0 @0   Type: (7) addr: 0x7fffd9210570 Is linked? [NO]
					#--!Assignment[5], line 0 @0   Type: (4) addr: 0x7fffd92109d0 Is linked? [NO]
						#--loopCount[0], line 68 @0   Type: (0) addr: 0x7fffd9210650 Is linked? [NO]
				#--!Statements[1], line 0 @0   Type: (2) addr: 0x7fffd9214b70 Is linked? [NO]
					#--!Return[0], line 0 @0   Type: (7) addr: 0x7fffd9210bb0 Is linked? [NO]
	#--divwithrest[4], line 75 @0  Funcdef (parmcount: 3) Type: (8) addr: 0x7fffd9211c30 Is linked? [NO]
		#--a[0], line 75 @1   Type: (9) addr: 0x7fffd9211d70 Is linked? [NO]
		#--b[1], line 75 @2   Type: (9) addr: 0x7fffd9211fd0 Is linked? [NO]
		#--lrest[2], line 75 @3   Type: (9) addr: 0x7fffd9212110 Is linked? [NO]
		#--cur[3], line 77 @0   Type: (12) addr: 0x7fffd9212250 Is linked? [NO]
		#--cnt[4], line 78 @0   Type: (12) addr: 0x7fffd92124d0 Is linked? [NO]
		#--rest[5], line 79 @0   Type: (12) addr: 0x7fffd9212730 Is linked? [NO]
		#--divrest[6], line 80 @0   (LOOP)  Type: (1) addr: 0x7fffd9212990 Is linked? [NO]
			#--!Assignment[0], line 0 @0   Type: (4) addr: 0x7fffd9212d30 Is linked? [NO]
				#--rest[0], line 81 @0   Type: (0) addr: 0x7fffd9212ad0 Is linked? [NO]
			#--!Assignment[1], line 0 @0   Type: (4) addr: 0x7fffd92132d0 Is linked? [NO]
				#--cur[0], line 82 @0   Type: (0) addr: 0x7fffd9212e10 Is linked? [NO]
			#--!If[2], line 0 @0   Type: (3) addr: 0x7fffd92185f0 Is linked? [NO]
				#--!Statements[0], line 0 @0   Type: (2) addr: 0x7fffd9213c70 Is linked? [NO]
					#--!Assignment[0], line 0 @0   Type: (4) addr: 0x7fffd92139b0 Is linked? [NO]
						#--cnt[0], line 84 @0   Type: (0) addr: 0x7fffd9213630 Is linked? [NO]
				#--!Statements[1], line 0 @0   Type: (2) addr: 0x7fffd9218210 Is linked? [NO]
					#--!Loopref[0], line 0 @0   Type: (5) addr: 0x7fffd9213bb0 Is linked? [NO]
						#--divrest[0], line 86 @0   Type: (0) addr: 0x7fffd9213a90 Is linked? [NO]
		#--!Assignment[7], line 0 @0   Type: (4) addr: 0x7fffd9215990 Is linked? [NO]
		#--!Return[8], line 0 @0   Type: (7) addr: 0x7fffd9215b90 Is linked? [NO]
	#--const1[5], line 93 @0  Funcdef (parmcount: 0) Type: (8) addr: 0x7fffd9215c70 Is linked? [NO]
		#--!Return[0], line 0 @0   Type: (7) addr: 0x7fffd9215fd0 Is linked? [NO]
	#--const2[6], line 94 @0  Funcdef (parmcount: 0) Type: (8) addr: 0x7fffd92160b0 Is linked? [NO]
		#--!Return[0], line 0 @0   Type: (7) addr: 0x7fffd9216410 Is linked? [NO]
	#--const3[7], line 95 @0  Funcdef (parmcount: 0) Type: (8) addr: 0x7fffd92164f0 Is linked? [NO]
		#--!Return[0], line 0 @0   Type: (7) addr: 0x7fffd9216850 Is linked? [NO]
	#--calltest[8], line 97 @0  Funcdef (parmcount: 0) Type: (8) addr: 0x7fffd9216930 Is linked? [NO]
		#--p1[0], line 98 @0   Type: (12) addr: 0x7fffd9216b90 Is linked? [NO]
		#--p2[1], line 99 @0   Type: (12) addr: 0x7fffd9216df0 Is linked? [NO]
		#--p3[2], line 100 @0   Type: (12) addr: 0x7fffd9217050 Is linked? [NO]
		#--primes[3], line 101 @0   Type: (12) addr: 0x7fffd92189f0 Is linked? [NO]
		#--!Return[4], line 0 @0   Type: (7) addr: 0x7fffd92195d0 Is linked? [NO]
.text
.globl fib
	 .type fib, @function
.globl fib2
	 .type fib2, @function
.globl g
	 .type g, @function
.globl isPrime
	 .type isPrime, @function
.globl divwithrest
	 .type divwithrest, @function
.globl const1
	 .type const1, @function
.globl const2
	 .type const2, @function
.globl const3
	 .type const3, @function
.globl calltest
	 .type calltest, @function
fib: ##    Function     (no. of params: 3, declared vars: 0) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	cmp $0, %rdx
	jg __LAB8
	MOVQ $-1, %rax
	jmp __LAB9
	__LAB8:
	MOVQ $0, %rax
	__LAB9:
	test $1, %rax
	jz __LAB7 
	movq %rsi, %rax
	leave 			# leave function  
	ret
	jmp __LAB0
__LAB7:
	# save argument registers (count 3) 
	pushq %rdi
	pushq %rsi
	pushq %rdx
	movq %rsi, %r10
	pushq %r10
		# binop called lhs: rdi (ADDQ) rhs: rsi
	movq %rdi, %rax
	ADDQ %rsi, %rax
		# end binop
	movq %rax, %r10
	pushq %r10
	movq $-1, %rax
	addq %rdx, %rax
	movq %rax, %r10
	pushq %r10
	popq %rdx
	popq %rsi
	popq %rdi
	pushq %rax 		# store rax for call
	pushq %r10 		# store r10 for call
	pushq %r11 		# store r11 for call
	call fib
	popq %r11 		# retrive old r11 value
	popq %r10 		# retrive old r10 value
	movq %rax, %r10
	popq %rax 		# retrive old rax value
	popq %rdx
	popq %rsi
	popq %rdi
	movq %r10, %rax
	leave 			# leave function  
	ret
__LAB0:
fib2: ##    Function     (no. of params: 2, declared vars: 4) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	SUBQ $32, %rsp 		# reserve space for 4 vars

	movq $0, -8(%rbp)
	movq $1, -16(%rbp)
__fib3:
	cmp $0, %rdi
	je __LAB11
	MOVQ $-1, %rax
	jmp __LAB12
	__LAB11:
	MOVQ $0, %rax
	__LAB12:
	test $1, %rax
	jz __LAB10 
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
	jmp __LAB1
__LAB10:
	movq $3, -24(%rbp)
	jmp __endfib3
__LAB1:
	jmp __fib3 # loops 
 __endfib3:
	movq $300, -32(%rbp)
		# binop called lhs: -16(%rbp) (ADDQ) rhs: -32(%rbp)
	movq -16(%rbp), %rax
	ADDQ -32(%rbp), %rax
		# end binop
	leave 			# leave function  
	ret
g: ##    Function     (no. of params: 2, declared vars: 3) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
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
	movq -8(%rbp), %r10
	ADDQ %rax, %r10
		# end binop
	movq %r10, -8(%rbp)
	movq -8(%rbp), %r10
	cmp $0, %r10
	jl __LAB14
	MOVQ $-1, %rax
	jmp __LAB15
	__LAB14:
	MOVQ $0, %rax
	__LAB15:
	test $1, %rax
	jz __LAB13 
	movq $1, %rax
	addq -16(%rbp), %rax
	movq %rax, -16(%rbp)
	jmp __LAB2
__LAB13:
	jmp __enddiv
__LAB2:
	jmp __div # loops 
 __enddiv:
	movq -16(%rbp), %rax
	leave 			# leave function  
	ret
isPrime: ##    Function     (no. of params: 1, declared vars: 4) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	SUBQ $32, %rsp 		# reserve space for 4 vars

	movq $2, -8(%rbp)
__checkPrime:
	movq $-1, %rax
	addq %rdi, %rax
	movq -8(%rbp), %r11
	cmp %rax, %r11
	jg __LAB17
	MOVQ $-1, %r10
	jmp __LAB18
	__LAB17:
	MOVQ $0, %r10
	__LAB18:
	movq %r10, %rax
	test $1, %rax
	jz __LAB16 
	movq $0, -16(%rbp)
	movq %rdi, -24(%rbp)
	movq $0, -32(%rbp)
__div1:
	movq -24(%rbp), %rax
	movq %rax, -16(%rbp)
	movq -8(%rbp), %rax
	NEGQ %rax
		# binop called lhs: -24(%rbp) (ADDQ) rhs: rax
	movq -24(%rbp), %r10
	ADDQ %rax, %r10
		# end binop
	movq %r10, -24(%rbp)
	movq -24(%rbp), %r10
	cmp $0, %r10
	jg __LAB19
	MOVQ $-1, %rax
	jmp __LAB20
	__LAB19:
	MOVQ $0, %rax
	__LAB20:
	movq -24(%rbp), %r11
	cmp $0, %r11
	je __LAB21
	MOVQ $-1, %r10
	jmp __LAB22
	__LAB21:
	MOVQ $0, %r10
	__LAB22:
		# binop called lhs: rax (ANDQ) rhs: r10
	movq %rax, %r11
	ANDQ %r10, %r11
		# end binop
	movq %r11, %rax
	test $1, %rax
	jz __LAB4
	jmp __enddiv1
__LAB4:
	jmp __div1 # loops 
 __enddiv1:
	movq -16(%rbp), %r10
	cmp $0, %r10
	jg __LAB23
	MOVQ $-1, %rax
	jmp __LAB24
	__LAB23:
	MOVQ $0, %rax
	__LAB24:
	movq -16(%rbp), %r11
	cmp $0, %r11
	jl __LAB25
	MOVQ $-1, %r10
	jmp __LAB26
	__LAB25:
	MOVQ $0, %r10
	__LAB26:
		# binop called lhs: rax (ANDQ) rhs: r10
	movq %rax, %r11
	ANDQ %r10, %r11
		# end binop
	movq %r11, %rax
	test $1, %rax
	jz __LAB5
	movq $0, %rax
	leave 			# leave function  
	ret
__LAB5:
	movq $1, %rax
	addq -8(%rbp), %rax
	movq %rax, -8(%rbp)
	jmp __LAB3
__LAB16:
	movq $1, %rax
	leave 			# leave function  
	ret
__LAB3:
	jmp __checkPrime # loops 
 __endcheckPrime:
divwithrest: ##    Function     (no. of params: 3, declared vars: 3) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
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
	movq -8(%rbp), %r10
	ADDQ %rax, %r10
		# end binop
	movq %r10, -8(%rbp)
	movq -8(%rbp), %r10
	cmp $0, %r10
	jl __LAB28
	MOVQ $-1, %rax
	jmp __LAB29
	__LAB28:
	MOVQ $0, %rax
	__LAB29:
	test $1, %rax
	jz __LAB27 
	movq $1, %rax
	addq -16(%rbp), %rax
	movq %rax, -16(%rbp)
	jmp __LAB6
__LAB27:
	jmp __enddivrest
__LAB6:
	jmp __divrest # loops 
 __enddivrest:
	movq %rdx, %rax
	pushq %rax
	movq -24(%rbp), %rax
	popq %r10
	movq %rax, (%r10)
	movq -16(%rbp), %rax
	leave 			# leave function  
	ret
const1: ##    Function     (no. of params: 0, declared vars: 0) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	movq $1, %rax
	leave 			# leave function  
	ret
const2: ##    Function     (no. of params: 0, declared vars: 0) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	movq $2, %rax
	leave 			# leave function  
	ret
const3: ##    Function     (no. of params: 0, declared vars: 0) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

	movq $3, %rax
	leave 			# leave function  
	ret
calltest: ##    Function     (no. of params: 0, declared vars: 4) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	SUBQ $32, %rsp 		# reserve space for 4 vars

	movq $11, -8(%rbp)
	movq $13, -16(%rbp)
	movq $27, -24(%rbp)
	# save argument registers (count 0) 
	pushq %rax 		# store rax for call
	pushq %r10 		# store r10 for call
	pushq %r11 		# store r11 for call
	call const1
	popq %r11 		# retrive old r11 value
	popq %r10 		# retrive old r10 value
	movq %rax, %r10
	popq %rax 		# retrive old rax value
	# save argument registers (count 0) 
	pushq %rax 		# store rax for call
	pushq %r10 		# store r10 for call
	pushq %r11 		# store r11 for call
	call const3
	popq %r11 		# retrive old r11 value
	popq %r10 		# retrive old r10 value
	movq %rax, %r11
	popq %rax 		# retrive old rax value
		# binop called lhs: r10 (imulq) rhs: r11
	movq %r10, %rax
	imulq %r11, %rax
		# end binop
	# save argument registers (count 0) 
	pushq %rax 		# store rax for call
	pushq %r10 		# store r10 for call
	pushq %r11 		# store r11 for call
	call const3
	popq %r11 		# retrive old r11 value
	popq %r10 		# retrive old r10 value
	movq %rax, %r10
	popq %rax 		# retrive old rax value
		# binop called lhs: rax (imulq) rhs: r10
	movq %rax, %r11
	imulq %r10, %r11
		# end binop
	# save argument registers (count 1) 
	pushq %rdi
	movq $11, %r10
	pushq %r10
	popq %rdi
	pushq %rax 		# store rax for call
	pushq %r10 		# store r10 for call
	pushq %r11 		# store r11 for call
	call isPrime
	popq %r11 		# retrive old r11 value
	popq %r10 		# retrive old r10 value
	movq %rax, %r10
	popq %rax 		# retrive old rax value
	popq %rdi
		# binop called lhs: r11 (ADDQ) rhs: r10
	movq %r11, %rax
	ADDQ %r10, %rax
		# end binop
	movq %rax, -32(%rbp)
	movq -32(%rbp), %rax
	leave 			# leave function  
	ret
