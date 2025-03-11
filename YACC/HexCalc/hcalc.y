%{
#include <stdio.h>
#include <stdlib.h> // for strtol
extern int yylex();
extern int yyerror(char *s);

%}

/* Declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%

calclist: /* nothing */
 | calclist exp EOL { printf("= %d (0x%x)\n", $2, $2); } // Print result in decimal and hex
 ;

exp: factor       { $$ = $1; }
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term       { $$ = $1; }
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER  { $$ = $1; }
 | ABS term   { $$ = $2 >= 0? $2 : -$2; }
;

%%

int main() {
    printf("Enter arithmetic expressions in hexadecimal(i.e. 0xa + 0x8):\n");
    yyparse(); // Call the parser
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}