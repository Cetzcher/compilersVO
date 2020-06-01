#--!root[0], line 0 @0  Type: (0) addr: 0x7fffbd1670b0
	#--f[0], line 1 @0  Funcdef (parmcount: 2) addr: 0x7fffbd1631d0
		#--a[0], line 1 @1  Type: (9) addr: 0x7fffbd163310
		#--b[1], line 1 @2  Type: (9) addr: 0x7fffbd163570
		#--x0[2], line 14 @0  Type: (12) addr: 0x7fffbd1636b0
		#--x1[3], line 15 @0  Type: (12) addr: 0x7fffbd163910
		#--fib[4], line 16 @0   (LOOP)  addr: 0x7fffbd163b70
			#--!If[0], line 0 @0  Type: (3) addr: 0x7fffbd165d30
				#--!Statements[0], line 0 @0  Type: (2) addr: 0x7fffbd165950
					#--tmp[0], line 18 @0  Type: (12) addr: 0x7fffbd163f30
					#--!Assignment[1], line 0 @0  Type: (4) addr: 0x7fffbd164550
						#--x1[0], line 19 @0  Type: (0) addr: 0x7fffbd1641b0
					#--!Assignment[2], line 0 @0  Type: (4) addr: 0x7fffbd164890
						#--x0[0], line 20 @0  Type: (0) addr: 0x7fffbd164630
					#--!Assignment[3], line 0 @0  Type: (4) addr: 0x7fffbd164e10
						#--a[0], line 21 @0  Type: (0) addr: 0x7fffbd164970
				#--!Statements[1], line 0 @0  Type: (2) addr: 0x7fffbd165330
					#--s[0], line 23 @0  Type: (12) addr: 0x7fffbd164ef0
					#--!Loopref[1], line 0 @0  Type: (5) addr: 0x7fffbd165270
						#--fib[0], line 24 @0  Type: (0) addr: 0x7fffbd165150
		#--last[5], line 27 @0  Type: (12) addr: 0x7fffbd166a10
		#--!Return[6], line 0 @0  Type: (7) addr: 0x7fffbd166ed0
.text
.globl f
	 .type f, @function
f: ##    Function     (no. of params: 2, declared vars: 4) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx
	SUBQ $32, %rsp 		# reserve space for 4 vars

	movq $0, -8(%rbp)
	movq $1, -16(%rbp)
__fib:
	movq %rdi, %rax
	cmp $0, %rax
	je __LAB2
	MOVQ $-1, %rax
	jmp __LAB3
	__LAB2:
	MOVQ $0, %rax
	__LAB3:
	test $1, %rax
	jz __LAB1 
	movq -16(%rbp), %rax
	movq %rax, -24(%rbp)
# binop called lhs: -8(%rbp) (ADDQ) rhs: -16(%rbp)
	movq -8(%rbp), %rax
	movq %rax, %rax
	ADDQ -16(%rbp), %rax
# end binop
	movq %rax, -16(%rbp)
	movq -24(%rbp), %rax
	movq %rax, -8(%rbp)
	movq $-1, %rax
	addq %rdi, %rax
	movq %rax, %rdi
	jmp __LAB0
__LAB1:
	movq $3, -24(%rbp)
	jmp __endfib
__LAB0:
	jmp __fib # loops 
 __endfib:
	movq $300, -32(%rbp)
# binop called lhs: -16(%rbp) (ADDQ) rhs: -32(%rbp)
	movq -16(%rbp), %rax
	movq %rax, %rax
	ADDQ -32(%rbp), %rax
# end binop
	POPQ %rbx
	leave 			# leave function  
	ret
