#include "stdio.h"
#include "stdlib.h"
#include "ctype.h"

const char *input; 
char lookahead; 

void match(char expected) {
    if (lookahead == expected) {
        lookahead = *++input;
    } else {
        printf("Syntax error: expected %c, found %c", expected, lookahead);
        exit(1);
    }
}

void match_v2(char *s) {
    for (int i = 0; s[i] != '\0'; i++) {
        match(s[i]);
    }
}

void syntax_error() {
    printf("Sytax Error\n");
    exit(1);
}

void absorb_whitespace() {
    while (lookahead == ' ') lookahead = *++input;
}

void C() {
    if (isalnum(lookahead)) {
        printf("C -> id");
        match(lookahead); 
        absorb_whitespace();
        if (lookahead == '=') {
            printf("==");
            match_v2("==");
            absorb_whitespace();
        } else if (lookahead == '!') {
            printf("!=");
            match_v2("!="); 
            absorb_whitespace();
        } else syntax_error();
        
        if (isalnum(lookahead)){
            printf("num\n");
            match(lookahead);
            absorb_whitespace();
        }
        else syntax_error();
    } else syntax_error();
}

void S() {
    if (lookahead == 'i') {
        printf ("S -> if C then S\n"); 
        match_v2("if"); 
        absorb_whitespace();
        C(); 
        absorb_whitespace();
        match_v2("then");
        absorb_whitespace();
        S();
        absorb_whitespace();

    } else if (lookahead == 'w') {
        printf("S -> while C do S\n");
        match_v2("while"); 
        absorb_whitespace();
        C(); 
        absorb_whitespace();
        match_v2("do");
        absorb_whitespace();
        S(); 
        absorb_whitespace();
    } else if (isalnum(lookahead)) {
        printf("S -> id");
        match(lookahead); 
        absorb_whitespace();
        if (lookahead == '=') {
            printf("=");
            absorb_whitespace();
            match('=');
            absorb_whitespace();
            if (isalnum(lookahead)) {
                printf("num");
                match(lookahead);
                absorb_whitespace();
            } else {
                syntax_error();
            }
        } else if (lookahead == '+') {
            printf("++");
            match_v2("++");
            absorb_whitespace();
        } else {
            syntax_error();
        }
        
        if (lookahead == ';') { 
            printf(";\n");
            match(lookahead);
            absorb_whitespace();
        }
        else syntax_error();
    }
}

int main() {
    input = (char *)malloc(100 * sizeof(char));

    input = "if 2 == 3 then 3 = 2;";
    //printf("Input an arithmetic expression\n");

    //while (scanf("%s", input) != EOF) {
    lookahead = *input; 
    printf("Parsing input: %s\n", input);
    S(); 
    if (lookahead == '\0') {
        printf("Parsing successful!\n");
    } else {
        syntax_error();
    }
    //}
    
}