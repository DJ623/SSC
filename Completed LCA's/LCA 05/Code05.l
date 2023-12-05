%{
#include<stdio.h>
#include<string.h>
typedef struct node {
char ID[10], Type[10];
struct node *next;
}node;
node *head = NULL, *curr=NULL, *prev=NULL;
int declare_flag = 0;
%}

delim [ \t\n]
ws {delim}+
letter [a-zA-Z]
digit [0-9]
package {letter}+\.{letter}+(\.{letter}+[*]?)*
Id {letter}({letter}|{digit}|(\_))*
Number {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
anychar ({letter}|{digit}|[ !@#$%^&*()_.,?:])*
String \"{anychar}\"

%%

{ws}
"System.out.println"|"System.out.print" {printf("\n%s : Print Statement",yytext);}
{package} {printf("\n%s : Package",yytext);}
class+" "+{letter}+ {printf("\n%s : Class",yytext);}
import|if|else {printf("\n%s : Keyword",yytext);}
{String} {printf("\n%s : String",yytext);}
"+"|"-"|"*"|"/"|"=" {printf("\n%s : Operator",yytext);}
{Number} {printf("\n%s : Number",yytext);}
"("|")"|"{"|"}"|";"|"}" {printf("\n%s : Punctuation",yytext);}
int|float|char|double {
printf("\n%s : Data Type",yytext);
prev = curr;
curr = curr->next;
curr = (node*)malloc(sizeof(node));
prev->next=curr;
strcpy(curr->Type, yytext);
declare_flag=1;}
{Id} {
printf("\n%s : Identifier",yytext);
if(declare_flag==1)
{
strcpy(curr->ID, yytext);
declare_flag=0;
}}
"*/"
"//"+{anychar}*"\n"|"/*"+{anychar}*"*/" {printf("\n%s : Comment",yytext);}
%%
int main()
{
head = (node*)malloc(sizeof(node));
curr = head;
yyin=fopen("Java_Sample.txt","r");
yylex();
printf("\n\nSymbol Table:\nID\tType\n");
node *temp = head->next;
while(temp!= NULL)
{
printf("%s\t%s\n",temp->ID,temp->Type);
temp=temp->next;
}
}
int yywrap()
{
return 1;
}

