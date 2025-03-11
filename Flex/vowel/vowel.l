
%{
#include<stdio.h>
int v=0, c=0;
%}
%%
[ \t\n]+ ;
[aeiouAEIOU] {v++;}
[^aeiouAEIOU] {c++;}
%%
int main()
{
printf("Enter input:\n");
yylex();
printf("Number of vowels: %d\n", v);
printf("Number of consonents: %d\n", c);
}
int yywrap()
{
return 1;
}