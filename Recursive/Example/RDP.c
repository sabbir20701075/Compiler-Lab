/*
Recursive Descent Parsing Functions for the following CFG:
E -> T E'
E' -> + T E' | ε
T -> F T'
T' -> * F T' | ε
F -> (E) | id
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

// Global variable for the input expression and pointer to current character
const char *input;
char lookahead;

// Function declarations for recursive parsing
void E();
void E_prime();
void T();
void T_prime();
void F();

// Helper function to match and move forward in the input
void match(char expected)
{
    if (lookahead == expected)
    {
        lookahead = *++input; // Move to the next character
    }
    else
    {
        printf("Syntax Error: Expected '%c', found '%c'\n", expected, lookahead);
        exit(1);
    }
}

// Function to parse Expression: E -> T E'
void E()
{
    printf("E -> T E'\n");
    T();
    E_prime();
}

// Function to parse E' -> + T E' | ε
void E_prime()
{
    if (lookahead == '+')
    {
        printf("E' -> + T E'\n");
        match('+');
        T();
        E_prime();
    }
    else
    {
        printf("E' -> ε\n"); // ε production
    }
}

// Function to parse Term: T -> F T'
void T()
{
    printf("T -> F T'\n");
    F();
    T_prime();
}

// Function to parse T' -> * F T' | ε
void T_prime()
{
    if (lookahead == '*')
    {
        printf("T' -> * F T'\n");
        match('*');
        F();
        T_prime();
    }
    else
    {
        printf("T' -> ε\n"); // ε production
    }
}

// Function to parse Factor: F -> (E) | id
void F()
{
    if (lookahead == '(')
    {
        printf("F -> (E)\n");
        match('(');
        E();
        match(')');
    }
    else if (isalnum(lookahead))
    {
        printf("F -> id\n");
        match(lookahead); // Match identifier/number
    }
    else
    {
        printf("Syntax Error: Unexpected character '%c'\n", lookahead);
        exit(1);
    }
}

// Main function to start parsing
int main()
{
    // Input arithmetic expression
    // input = "(2++3)*5";
     input = (char *)malloc(100 * sizeof(char));

    printf("Input an arithmetic expression\n");
    while (scanf("%s", input) != EOF)
    {

        lookahead = *input; // Initialize lookahead

        printf("Parsing input: %s\n", input);

        E(); // Start parsing from the start symbol E

        if (lookahead == '\0')
        {
            printf("Parsing successful!\n");
        }
        else
        {
            printf("Syntax Error: Unexpected input after parsing.\n");
        }
        printf("Input an arithmetic expression\n");
    }

    return 0;
}