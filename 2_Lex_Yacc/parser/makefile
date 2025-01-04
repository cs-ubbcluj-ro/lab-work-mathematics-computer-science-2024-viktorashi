Sfantu_c_parser:
	flex lexeru.lex
	yacc -dv parser.y
	clang lex.yy.c y.tab.c -ly -ll -o parser.out
	./parser.out primele-prime.lol