funclang: 
	ox parser.y scanner.flex
	yacc -d -v -t oxout.y
	flex oxout.l
	bfe < code.bfe | iburg > code.c
	gcc -g scope.c code.c instructions.c lex.yy.c y.tab.c -w   -lm -o parser

clean:
	rm oxout.*
	rm y.output
	rm y.tab.*
	rm parser
	rm lex.yy.c
