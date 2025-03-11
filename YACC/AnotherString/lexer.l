%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"

%}

%option noyywrap

%%

[a-zA-Z]+          { yylval.str = strdup(yytext); return STRING; }  /* Match alphabetic strings */
"+"                { return PLUS; }
"*"                { return STAR; }
\'[0-9]+\'          { yylval.num = atoi(yytext+1); return NUMBER; }  /* Match 'n' for repetition (e.g., '3') */
\n                 { return EOL; }
[ \t]              { /* ignore whitespace */ }
.                  { printf("Unrecognized character: %c\n", *yytext); }

%%