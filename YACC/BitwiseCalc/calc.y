%{
#include <stdio.h>
#include <stdlib.h> // For standard functions

extern int yylex();
extern int yyerror(const char *s);
%}

/* Define a union for YYSTYPE */
%union {
    int int_val;
}

/* Declare tokens */
%token <int_val> NUMBER
%token ADD SUB MUL DIV AND OR EOL

%type <int_val> exp factor term

%%
calclist:
    /* nothing */
    | calclist exp EOL { printf("= %d\n", $2); } // Print result
    ;

exp:
    factor { $$ = $1; }
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 - $3; }
    | exp OR factor  { $$ = $1 | $3; } // Bitwise OR
    ;

factor:
    term { $$ = $1; }
    | factor MUL term { $$ = $1 * $3; }
    | factor DIV term { 
        if ($3 == 0) {
            yyerror("Division by zero!"); 
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | factor AND term { $$ = $1 & $3; } // Bitwise AND
    ;

term:
    NUMBER { $$ = $1; }
    ;
%%

int main() {
    yyparse(); // Call the parser
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
