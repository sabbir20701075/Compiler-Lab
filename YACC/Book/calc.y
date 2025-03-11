%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

/* Declare tokens */
%token NUMBER
%token ADD SUB MUL DIV
%token ABS  /* Absolute value '|' */
%token EOL

/* Operator precedence */
%left ADD SUB
%left MUL DIV
%right ABS

%%

calclist:
        /* empty */
      | calclist exp EOL { printf("= %d\n", $2); }
      ;

exp: 
        factor 
      | exp ADD factor { $$ = $1 + $3; }
      | exp SUB factor { $$ = $1 - $3; }
      ;

factor:
        term 
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term { 
            if ($3 == 0) {
                yyerror("Division by zero");
                $$ = 0;
            } else {
                $$ = $1 / $3;
            }
        }
      ;

term: 
        NUMBER { $$ = $1; }
      | ABS exp ABS { $$ = ($2 >= 0) ? $2 : -$2; }  
      ;

%%

int main() {
    printf("Simple Calculator (Type expressions and press Enter)\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
