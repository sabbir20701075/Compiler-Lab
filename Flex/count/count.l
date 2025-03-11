%{
    #include <stdio.h>
    #include <string.h>

    int chars = 0;
    int words = 0;
    int lines = 0;

%}

%%

[a-zA-Z]+  { words++; chars += strlen(yytext); }
\n         { lines++; chars++; }
.          { chars++; }

%%

int main() {
    yyin = fopen("input.txt", "r");
    yyout=fopen("output.txt","w");
   

    yylex();
    
    fprintf(yyout,"# of words: %d\n", words);
    fprintf(yyout,"# of lines: %d\n", lines);
    fprintf(yyout,"# of characters: %d\n", chars);

    fclose(yyin);
    fclose(yyout);


    return 0;
}

int yywrap() {
    return 1;
}
