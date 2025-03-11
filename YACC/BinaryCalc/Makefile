all:
	bison -d Bcalc.y
	flex Bcalc.l
	gcc -o calculator.exe Bcalc.tab.c lex.yy.c
	.\calculator.exe
