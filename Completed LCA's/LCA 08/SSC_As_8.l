%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}
%%
[ \t\n] ;
"print" {return PRINT;}
"exit" {return STOP;}
[a-zA-Z] {yylval.id = yytext[0]; return ID;}
[0-9]+ {yylval.num = atoi(yytext); return NUM;}
[-+*/%=;] {return yytext[0];}
. {yyerror ("unexpected character");}

%%
int yywrap (void)
{
return 1;
}