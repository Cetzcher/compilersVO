%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "scope.h"
#define toHex convertHex(yytext)
int line_number = 0;
int convertHex(char*);

%}
%option yylineno

DIGIT  [0-9]
HEXPREFIX   "0x"
HEXDIGIT    [0-9a-fA-F]
ID          [a-zA-Z_][a-zA-Z0-9_]*

%%
if                                                  { return TIF; }
then                                                { return TTHEN;}
else                                                { return TELSE; }
end                                                 { return TEND; }
return                                              { return TRETURN; }
loop                                                { return TLOOP; }
break                                               { return TBREAK; }
cont                                                { return TCONT; }
var                                                 { return TVAR; }
not                                                 { return TNOT; }
and                                                 { return TAND; }
{HEXPREFIX}{HEXDIGIT}+                              return number; @{@number.value@ = convertHex(yytext); @}
{DIGIT}+                                            return number; @{@number.value@ = atoi(yytext); @}
{ID}                                                return id; @{ @id.sym@ = single2(strdup(yytext), yylineno);@}
"("                                                 { /*printf("lparen\n");            */ return '(';}
")"                                                 { /*printf("rparen\n");            */ return ')';}
","                                                 { /*printf("comma\n");             */ return ',';}
";"                                                 { /*printf("semicolon\n");         */ return ';';}
":"                                                 { /*printf("colon\n");             */ return ':';}
":="                                                { /*printf("assignment\n");        */ return assignment;}
"*"                                                 { /*printf("times\n");             */ return '*';}
"-"                                                 { /*printf("minus\n");             */ return '-';}
"+"                                                 { /*printf("plus\n");              */ return '+';}
"<="                                                { /*printf("smallerThan\n");       */ return lessThan;}
"#"                                                 { /*printf("#\n");                 */ return '#'; }
"//".*                                              /* eat up comments */
[ \t\r]*                                            /* eat up whitespace characters*/
\n                                                  { line_number++; }
.                                                   { printf("lexical error near line %d\n", line_number); exit(1); }
%% 
  
 /* User code section*/
 int yywrap(){} 
 int convertHex(char* text) {
    // the first two characters are 0x so we start at index 2
    const size_t len = strlen(text);
    int hex = 0;
    int exp = len - 3;
    for(int i = 2; i < len; i++) {
        char cur = text[i];
        int val = 0;
        if('0' <= cur && cur <= '9') {
            val = cur - '0';
        } else if(cur == 'A' || cur == 'a') {
            val = 10;
        } else if(cur == 'B' || cur == 'b') {
            val = 11;
        } else if(cur == 'C' || cur == 'c') {
            val = 12;
        } else if(cur == 'D' || cur == 'd') {
            val = 13;
        } else if(cur == 'E' || cur == 'e') {
            val = 14;
        } else if(cur == 'F' || cur == 'F') {
            val = 15;
        }
        hex += pow(16, exp) * val;
        exp--;
    }
    return hex;
}
 /*
 void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
int main(int argc, char **argv) 
{ 
  
yylex(); 
printf("end");
  
return 0; 
}  */