%{
#include <iostream>
#include <string>
#include <vector>
#include <stdio.h>
#include "Node.h"

using namespace std;

// stuff from lex that yacc needs to know about:
extern int yylex();
extern int yyparse();
extern FILE *yyin;

//Defined below.
void yyerror(const char *s);

Node *rootNode;

%}

%locations

%union {
    int ival;
    char *sval;
    Node *node;
}

%start line
%type <node> expr

%token <ival> INT
%token <sval> ID
%token ')'

%left '-' '+'
%left '*' '/' ITIMES INT ID '('
%right UMINUS UPLUS
%right '^'

%%

line
:   expr    { rootNode = $1; }
;

expr
:   ID                      { $$ = new Node($1, NULL, NULL); }
|   INT                     { $$ = new Node(to_string($1), NULL, NULL); }
|   '(' expr ')'            { $$ = new Node("[()]", $2, NULL); }
|   expr '^' expr           { $$ = new Node("[^]", $1, $3);}
|   '-' expr %prec UMINUS   { $$ = new Node("UMINUS", $2, NULL); }
|   '+' expr %prec UPLUS    { $$ = new Node("UPLUS", $2, NULL); }
|   expr expr %prec ITIMES  { $$ = new Node("[ITIMES]", $1, $2); }
|   expr '/' expr           { $$ = new Node("[/]", $1, $3); }
|   expr '*' expr           { $$ = new Node("[*]", $1, $3); }
|   expr '+' expr           { $$ = new Node("[+]", $1, $3); }
|   expr '-' expr           { $$ = new Node("[-]", $1, $3); }
;

%%


int main(int argc, char **argv){
    FILE *myfile = fopen("Expression.txt", "r");
    if (!myfile) {
        cout << "Can't open Expression.txt" << endl;
        return -1;
    }
    yyin = myfile;
    
    // parse through the input until there is no more:
    do {
        yyparse();
    } while (!feof(yyin));
    
    cout << "+Parse Tree" << endl;
    rootNode->PrintPretty("", true);
    
}

void yyerror(const char *s) {
    cout << "EEK, parse error!  Message: " << s << endl;
    // might as well halt now:
    exit(-1);
}