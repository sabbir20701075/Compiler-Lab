%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

/* Token declarations */
%token NUMBER
%token ADD SUB MUL DIV
%token LPAREN RPAREN  /* Parentheses tokens */
%token EOL

/* Operator precedence and associativity */
%left ADD SUB
%left MUL DIV
%left ABS 
%%

calclist:
      /* empty */
    | calclist EOL {printf("No output\n");}
    | calclist exp EOL { printf("= %d\n", $2); }
    ;

exp:
      exp ADD exp { $$ = $1 + $3; }
    | exp SUB exp { $$ = $1 - $3;   }
    | exp MUL exp { $$ = $1 * $3; }
    | exp DIV exp { 
          if ($3 == 0) {
              yyerror("Division by zero");
              $$ = 0;
          } else {
              $$ = $1 / $3;
          }
      }
    | LPAREN exp RPAREN { $$ = $2; }
    | NUMBER { $$ = $1; }
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
