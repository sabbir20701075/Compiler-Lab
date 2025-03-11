all:
	bison -d hcalc.y
	flex hcalc.l
	gcc -o calculator.exe hcalc.tab.c lex.yy.c
	.\calculator.exe
