--!root[0], line 0 @0  declared vars: 0
	--f[0], line 1 @0  Funcdef (parmcount: 2)
		--arg1[0], line 1 @1  declared vars: 0
		--arg2[1], line 1 @2  declared vars: 0
		--!Return[2], line 0 @0  declared vars: 0
.text
.globl f
	 .type f, @function

	##    Function      ##
f:
	# f (varcount 2, parmcount 0)
	PUSHQ %rbp 		# make room for basepointer
	MOVQ %rsp, %rbp 	# set frame pointer

--no name  Operator (0)
	--no name  Operator (1)
		--no name  Operator (1)
			--no name  Operator (12)
				--arg1[0], line 2 @0  var
			--no name  Operator (12)
				--arg1[0], line 2 @0  var
		--no name  Operator (12)
			--arg2[0], line 2 @0  var
