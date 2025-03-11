all:
	bison -d string_calc.y
	flex string_calc.l
	gcc -o calculator.exe string_calc.tab.c lex.yy.c
	.\calculator.exe