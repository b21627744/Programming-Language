KNK_parser: lex.yy.c y.tab.c
	gcc -o KNK_parser y.tab.c -lfl

y.tab.c: project.y
	yacc -d project.y

lex.yy.c: project.l
	lex project.l

clean:
	rm -rf lex.yy.c y.tab.c y.tab.h KNK_parser