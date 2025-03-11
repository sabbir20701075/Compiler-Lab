%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.tab.h"

extern int yylval;
%}

%%

"+"    { return ADD; }
"-"    {return SUB;  }
"*"    { return MUL; }
"/"    { return DIV; }
"("    { return LPAREN; }
")"    { return RPAREN; }
"-"?[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n     { return EOL; }
[ \t]  { /* Ignore whitespace */ }
.      { printf("Unrecognized character: %c\n", *yytext); }

%%

int yywrap() {
    return 1;
}
