all:
	bison -d calc.y
	flex calc.l
	gcc -o calculator.exe calc.tab.c lex.yy.c
	.\calculator.exe
