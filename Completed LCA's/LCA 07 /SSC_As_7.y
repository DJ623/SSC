%{
void yyerror(char *s);
#include<stdio.h>
#include<stdlib.h>
extern FILE *yyin;
extern int yylineno;
validflag = 0;
extern int yylex();
extern int yywrap();
extern int yyparse();
%}

%token IF ELSE WHILE DO NUM ID
%right '='
%left CONDOP '+' '-' '*' '/'

%%

S  :S1 {printf("Valid Compound Statement\n");};
S1 :WHILE '(' condition ')' S1
|IF '(' condition ')' S1 ELSE S1
|IF '(' condition ')' S1
|DO '{' S1 '}' WHILE '(' condition ')'';'
|'{' S1 '}'
|S1 S1
|ST
;

ST :ST ';'
|ST ';' S1
|ASSIGN
;
ASSIGN :ID '=' EXPR
;
EXPR :EXPR '+' EXPR
|EXPR '-' EXPR
|EXPR '*' EXPR
|EXPR '/' EXPR
|EXPR CONDOP EXPR
|EXPR '<' EXPR
|EXPR '>' EXPR
|ID
|NUM
;
condition :EXPR CONDOP EXPR
|EXPR '<' EXPR
|EXPR '>' EXPR
|ID
|NUM
;

%%
int main()
{
 yyin = fopen("As_7_Sample.txt","r");
 yyparse();
}

void yyerror (char *s) {
fprintf(stderr, "%d] %s\n", yylineno,s);
}