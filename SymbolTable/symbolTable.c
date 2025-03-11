#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TABLE_SIZE 100

// Symbol Table Entry
typedef struct Symbol {
    char name[50];
    char type[20];
    int scope;
    struct Symbol* next; // For collision handling (linked list)
} Symbol;

// Symbol Table (hash table)
Symbol* symbolTable[TABLE_SIZE];

// Hash function to calculate index
unsigned int hash(char* name) {
    unsigned int hashValue = 0;
    for (int i = 0; name[i] != '\0'; i++) {
        hashValue = 31 * hashValue + name[i];
    }
    return hashValue % TABLE_SIZE;
}

// Insert into the symbol table
void insert(char* name, char* type, int scope) {
    unsigned int index = hash(name);
    Symbol* newSymbol = (Symbol*) malloc(sizeof(Symbol));
    strcpy(newSymbol->name, name);
    strcpy(newSymbol->type, type);
    newSymbol->scope = scope;
    newSymbol->next = symbolTable[index];
    symbolTable[index] = newSymbol;
}

// Lookup a symbol in the table
Symbol* lookup(char* name) {
    unsigned int index = hash(name);
    Symbol* current = symbolTable[index];
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

int main() {
    insert("x", "int", 0);
    insert("y", "int", 1);

    Symbol* s = lookup("x");
    if (s != NULL) {
        printf("Found %s of type %s in scope %d\n", s->name, s->type, s->scope);
    } else {
        printf("Symbol not found\n");
    }

      s = lookup("y");
    if (s != NULL) {
        printf("Found %s of type %s in scope %d\n", s->name, s->type, s->scope);
    } else {
        printf("Symbol not found\n");
    }

    return 0;
}