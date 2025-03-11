%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int flag=0;
void print_number(const char *type, const char *lexeme);
%}

%%


0[xX][0-9a-fA-F]+ { print_number("Hexadecimal", yytext);flag=1; }


0[oO][0-7]+ { print_number("Octal", yytext); }


0[bB][01]+ { print_number("Binary", yytext); }


[ \t]+   { /* Skip whitespace */ }

\n  {
    if(flag==0){
        printf("Not recognized\n");
    }
    flag=0;
}


. { }

%%

void print_number(const char *type, const char *lexeme) {
    printf("%s: %s\n", type, lexeme);
}

int yywrap() {
    return 1;
}

int main() {
    printf("Enter numbers (Ctrl+D to stop):\n");
    yylex();
    return 0;
}
