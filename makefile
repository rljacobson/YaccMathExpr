all: MathExpr

MathExpr: parser.tab.o lex.yy.o Node.o
	g++ parser.tab.o lex.yy.o Node.o -ll -o MathExpr
	# Change -ll to -lfl if not on OSX.

Node.o: Node.h Node.cpp
	g++ -c Node.cpp

parser.tab.o: parser.tab.c
	g++ -c parser.tab.c

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

parser.tab.c: parser.y
	bison -d parser.y

lex.yy.c: lexer.lpp
	flex lexer.lpp

clean:
	rm -f *.o MathExpr parser.tab.* lex.yy.c

