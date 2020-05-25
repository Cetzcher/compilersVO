funclang: 
	ox parser.y scanner.flex
	yacc -d -v -t oxout.y
	flex oxout.l
	bfe < code.bfe | iburg > code.c
	gcc -g registerinfo.c scope.c code.c instructions.c lex.yy.c y.tab.c -w   -lm -o codea

clean:
	rm oxout.*
	rm y.output
	rm y.tab.*
	rm codea
	rm lex.yy.c
