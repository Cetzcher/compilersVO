#--!root[0], line 0 @0  Type: (0)
	#--f[0], line 1 @0  Funcdef (parmcount: 2)
		#--a[0], line 1 @1  Type: (9)
		#--b[1], line 1 @2  Type: (9)
		#--!Return[2], line 0 @0  Type: (7)
.text
.globl f
	 .type f, @function
f: ##    Function     (no. of params: 2, declared vars: 0) ##
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer
	PUSHQ %rbx

#--no name  Operator (8)
	#--no name  NUM <5>
	#--a[1], line 2 @0  var
	cmp $5, %rdi
	je __LAB0
	MOVQ $-1, %rax
	jmp __LAB1
	__LAB0:
	MOVQ $0, %rax
	__LAB1:
	#value is already in rax
	POPQ %rbx
	leave 			# leave function  
	ret
