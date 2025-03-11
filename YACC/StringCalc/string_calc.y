%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();
%}

%union {
    char* str;
    int num;
}

%token <str> STRING
%token <num> NUMBER
%token PLUS STAR EOL

%type <str> expr term

%%

calclist:
        /* empty */
      | calclist line
      ;

line:   expr EOL { printf("Result = %s\n", $1); free($1); }
      ;

expr:   term
      | expr PLUS term { 
          char* result = (char*)malloc(strlen($1) + strlen($3) + 1);
          strcpy(result, $1);
          strcat(result, $3);
          free($1); free($3);
          $$ = result;
      }
      ;

term:   STRING
      | term STAR NUMBER {
          int count = $3;  /* Use the int value directly */
          char* str = $1;
          int len = strlen(str);
          char* result = (char*)malloc(len * count + 1);
          result[0] = '\0';
          for (int i = 0; i < count; i++) {
              strcat(result, str);
          }
          free($1);
          $$ = result;
      }
      ;

%%

int main() {
    printf("String Algebra Calculator (Type expressions and press Enter)\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}