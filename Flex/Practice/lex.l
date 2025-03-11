%{
    #include<stdio.h>
    int keyword=0;
    int identifier=0;
    int others=0;
%}
%%
"do"|"while"|"for"|"return"|"int"|"float"|"main"|"include"|"stdio.h" {
    keyword++;
    fprintf(yyout,"\'%s\' is a keyword\n",yytext);
}
[a-zA-Z_][a-zA-Z0-9]* {
    identifier++;
    fprintf(yyout,"\'%s\' is an identifier\n",yytext);
}
. {others++;fprintf(yyout,"\'%s\' is an others\n",yytext);}

%%

int main(){
    yyin=fopen("input.c","r");
    yyout=fopen("output.txt","w");
    yylex();
    fprintf(yyout,"# of keyword is %d\n",keyword);
    fclose(yyin);
    fclose(yyout);
    return 0;
}
int yywrap(){
    return 1;
}
