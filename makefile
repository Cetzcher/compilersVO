
funclang: 
	ox flan2.y scanner.flex
	bison --report=all --report-file=pars.report -t -d -v  oxout.y
	flex oxout.l
	gcc -g scope.c lex.yy.c y.tab.c -w   -lm

all: 
	ox parser.y scanner.flex
	yacc -d -v  oxout.y
	flex oxout.l
	gcc scope.c lex.yy.c y.tab.c -w   -lm

reduced: 
	ox reduced.y scanner.flex
	yacc -d -v -t oxout.y
	flex oxout.l
	gcc scope2.c lex.yy.c y.tab.c -w   -lm



noox: 
	yacc -d -v parser.y
	flex scanner.flex
	gcc lex.yy.c y.tab.c scope.c -lm