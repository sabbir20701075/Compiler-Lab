%{
#include <stdio.h>
#include <stdlib.h> // for atoi
extern int yylex();
extern int yyerror(const char *s);
%}

/* Declare tokens */
%union {
    char char_val;
    int int_val;
}

%token LETTER DIGITS
%type <char_val> LETTER
%type <int_val> DIGITS expr

%%
input:
    /* nothing */
    | input expr '\n' { printf("Result = %c\n", $2); }
    ;

expr:
    LETTER '+' DIGITS {
        int letter_ascii = $1;
        int sum_digits = $3;
        int result_ascii = letter_ascii + sum_digits;

        // Handle cycling for lowercase letters (ASCII 'a' to 'z')
        if (letter_ascii >= 'a' && letter_ascii <= 'z') {
            result_ascii = 'a' + (result_ascii - 'a') % 26;
        }
        // Handle cycling for uppercase letters (ASCII 'A' to 'Z')
        else if (letter_ascii >= 'A' && letter_ascii <= 'Z') {
            result_ascii = 'A' + (result_ascii - 'A') % 26;
        }
        $$ = result_ascii; // Set the result
    }
    | expr '+' DIGITS {
        int current_result = $1;
        int sum_digits = $3;
        int result_ascii = current_result + sum_digits;

        // Handle cycling for lowercase letters (ASCII 'a' to 'z')
        if (current_result >= 'a' && current_result <= 'z') {
            result_ascii = 'a' + (result_ascii - 'a') % 26;
        }
        // Handle cycling for uppercase letters (ASCII 'A' to 'Z')
        else if (current_result >= 'A' && current_result <= 'Z') {
            result_ascii = 'A' + (result_ascii - 'A') % 26;
        }
        $$ = result_ascii; // Set the result
    }
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
