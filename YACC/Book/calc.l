%{
#include "calc.tab.h"

extern int yylval;
%}

%%
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
" -"?[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n     { return EOL; }
[ \t]  { /* ignore whitespace */ }
.      { printf("Unrecognized character: %c\n", *yytext); }

%%

int yywrap() {
    return 1;
}
