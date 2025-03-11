%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyerror(char *s);

void print_binary(int num) {
    int i;
    for (i = sizeof(int) * 8 - 1; i >= 0; i--) {
        putchar((num & (1 << i)) ? '1' : '0');
    }
    putchar('\n');
}

%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%

calclist: /* nothing */
         | calclist exp EOL {
             printf("= %d (0x%x) (0o%o) ", $2, $2, $2);  // Decimal, Hexadecimal, Octal
             print_binary($2);  // Print in Binary
         }
         ;

exp: factor             { $$ = $1; }
   | exp ADD factor     { $$ = $1 + $3; }
   | exp SUB factor     { $$ = $1 - $3; }
   ;

factor: term            { $$ = $1; }
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term { $$ = $1 / $3; }
      ;

term: NUMBER            { $$ = $1; }
    | ABS term          { $$ = $2 >= 0 ? $2 : -$2; } // Absolute value
    ;

%%

int main() {
    printf("Enter arithmetic expressions in binary, octal, hexadecimal, or decimal:\n");
    yyparse(); // Call the parser
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
