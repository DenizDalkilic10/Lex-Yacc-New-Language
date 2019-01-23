parser: y.tab.c
	gcc -o parser y.tab.c
y.tab.c: CS315f18_group28.yacc lex.yy.c
	yacc CS315f18_group28.yacc
lex.yy.c: CS315f18_group28.lex
	lex CS315f18_group28.lex
	