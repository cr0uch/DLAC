all:
	make clear
	make yacc
	make lex
	make yaccCalc
	make lexCalc
	make compile

clear:
	rm -f **/*.c
	rm -f **/*.h
	rm -f calc.exe
yacc: src/iexpr.y
	yacc -d -p ww src/iexpr.y -o build/iexpr.tab.c

lex: src/iexpr.l
	lex -o build/lex.ww.c src/iexpr.l 

yaccCalc: src/calc.y
	yacc -d src/calc.y -o build/calc.tab.c

lexCalc: src/calc.l
	lex -o build/lex.yy.c src/calc.l 

compile:
	gcc build/lex.ww.c build/iexpr.tab.c build/lex.yy.c build/calc.tab.c -o calc.exe -std=c99
