%{
#include <stdio.h>
#include <stdlib.h>
#include "Bcalc.tab.h"
%}

%%

[ \t]               ; // Skip whitespace
\n                  return EOL;  // End of line

"+"                 return ADD;
"-"                 return SUB;
"*"                 return MUL;
"/"                 return DIV;
"|"                 return ABS;

0[bB][01]+          { // Binary number (e.g., 0b1010 or 0B1010)
    yylval = (int)strtol(yytext + 2, NULL, 2); // Base 2 for binary
    return NUMBER;
}

0[xX][0-9a-fA-F]+  { // Hexadecimal number (e.g., 0x1F or 0X1F)
    yylval = (int)strtol(yytext + 2, NULL, 16); // Base 16 for hexadecimal
    return NUMBER;
}

0[oO][0-7]+             { // Octal number (e.g., 0o75)
    yylval = (int)strtol(yytext+2, NULL, 8); // Base 8 for octal
    return NUMBER;
}

"-"?[0-9]+              { // Decimal number
    yylval = atoi(yytext); // Convert decimal string to integer
    return NUMBER;
}

.                   { fprintf(stderr, "Invalid character: %s\n", yytext); } // Handle invalid input

%%

int yywrap() {
    return 1;
}
