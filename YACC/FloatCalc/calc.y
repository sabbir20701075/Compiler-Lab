%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyerror(const char *s);
%}

/* Declare the type of yylval */
%union {
    double dval; // Use double for floating-point numbers
}

/* Declare tokens */
%token ADD SUB MUL DIV ABS EOL QUIT
%token <dval> NUMBER
%type <dval> exp factor term

%%
calclist:
    /* nothing */
    | calclist exp EOL { printf("= %g\n", $2); } // Print result as floating-point number
    | calclist QUIT EOL { printf("Exiting calculator...\n"); exit(0); } // Exit command
    ;

exp:
    factor { $$ = $1; }
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 - $3; }
    ;

factor:
    term { $$ = $1; }
    | factor MUL term { $$ = $1 * $3; }
    | factor DIV term { 
        if ($3 == 0) {
            yyerror("Error: Division by zero!"); 
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    ;

term:
    NUMBER { $$ = $1; }
    | ABS term { $$ = $2 >= 0 ? $2 : -$2; } // Absolute value
    ;
%%

int main() {
    printf("Enter arithmetic expressions (type 'quit' to exit):\n");
    yyparse(); // Call the parser
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
