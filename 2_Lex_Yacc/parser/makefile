Sfantu_c_parser:
	flex lexeru.lex
	yacc -dv parser.y
	clang lex.yy.c y.tab.c -ly -ll -o rezultat.out
	./rezultat.out alttest.lol