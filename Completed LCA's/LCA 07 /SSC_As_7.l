%{
#include "y.tab.h"
%}

delim [ \t\n]
ws {delim}+
letter [a-zA-Z]
digit [0-9]
Id {letter}({letter}|{digit}|(\_))*
Number {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
anychar ({letter}|{digit}|[ !@#$%^&*()_.,?:])*
condop (<=)|(>=)|(==)|(!=)|("&&")|("||")

%%
{delim}
if return IF;
else return ELSE;
while return WHILE;
do return DO;
{Number} return NUM;
{Id} return ID;
{condop} return CONDOP;
. return yytext[0];
%%

int yywrap()
{
return 1;
}