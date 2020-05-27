#--!root[0], line 0 @0  Type: (0)
	#--f[0], line 1 @0  Funcdef (parmcount: 2)
		#--a[0], line 1 @1  Type: (9)
		#--b[1], line 1 @2  Type: (9)
		#--x[2], line 2 @0  Type: (12)
		#--!Assignment[3], line 0 @0  Type: (4)
			#--x[0], line 3 @0  Type: (0)
		#--!Return[4], line 0 @0  Type: (7)
.text
.globl f
	 .type f, @function
f: ##    Function     (no. of params: 2, declared vars: 1) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx
	SUBQ $8, %rsp 		# reserve space for 1 vars

#### set target called with -8(%rbp) 
# binop called lhs: rdi (ADDQ) rhs: rsi
	movq %rdi, %rax
	ADDQ %rsi, %rax
# end binop
 # finalize called
	movq %rax, -8(%rbp)
#### set target called with -8(%rbp) 
# finalizec called
	movq $3, -8(%rbp)
#### set target called with rax 
# finalize called
	movq -8(%rbp), %rax
	POPQ %rbx
	leave 			# leave function  
	ret
