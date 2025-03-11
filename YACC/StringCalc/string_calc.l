%{
#include <stdio.h>
#include <string.h>
#include "string_calc.tab.h"

%}

%option noyywrap

%%

[a-zA-Z]+          { yylval.str = strdup(yytext); return STRING; }  /* Match alphabetic strings */
"+"                { return PLUS; }
"*"                { return STAR; }
\'[0-9]\'          { yylval.num = yytext[1] - '0'; return NUMBER; }  /* Match 'n' for repetition (e.g., '3') */
[a-zA-Z]+\'[0-9]\' { 
    char* str = strdup(yytext);
    int len = strlen(str) - 3;  /* Length of string before 'n' */
    str[len] = '\0';           /* Truncate at quote */
    yylval.str = str;          /* Store string part (e.g., "C" from "C'3'") */
    return STRING;             /* Return STRING, next token will be NUMBER */
}
\n                 { return EOL; }
[ \t]              { /* ignore whitespace */ }
.                  { printf("Unrecognized character: %c\n", *yytext); }

%%