/* output from Ox version G1.04 */
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


%{


struct yyyT1 {long value; }; 
typedef struct yyyT1 *yyyP1; 


struct yyyT2 { SymbolTree* sym;}; 
typedef struct yyyT2 *yyyP2; 


struct yyyT3 {SymbolTree* op;}; 
typedef struct yyyT3 *yyyP3; 


struct yyyT4 {SymbolTree* ids; char* closelab; }; 
typedef struct yyyT4 *yyyP4; 


struct yyyT5 {SymbolTree* ids;}; 
typedef struct yyyT5 *yyyP5; 


struct yyyT6 { SymbolTree* context; SymbolTree* inherited; }; 
typedef struct yyyT6 *yyyP6; 
                                                      /*custom*/  
typedef unsigned char yyyWAT; 
typedef unsigned char yyyRCT; 
typedef unsigned short yyyPNT; 
typedef unsigned char yyyWST; 

#include <limits.h>
#define yyyR UCHAR_MAX  

 /* funny type; as wide as the widest of yyyWAT,yyyWST,yyyRCT  */ 
typedef unsigned short yyyFT;

                                                      /*stock*/  




struct yyyGenNode {void *parent;  
                   struct yyyGenNode **cL; /* child list */ 
                   yyyRCT *refCountList; 
                   yyyPNT prodNum;                      
                   yyyWST whichSym; /* which child of parent? */ 
                  }; 

typedef struct yyyGenNode yyyGNT; 



struct yyyTB {int isEmpty; 
              int typeNum; 
              int nAttrbs; 
              char *snBufPtr; 
              yyyWAT *startP,*stopP; 
             };  




extern struct yyyTB yyyTermBuffer; 
extern yyyWAT yyyLRCIL[]; 
extern void yyyGenLeaf(); 


%}
%%
if                                                  { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TIF;} }
then                                                { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TTHEN;}}
else                                                { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TELSE;} }
end                                                 { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TEND;} }
return                                              { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TRETURN;} }
loop                                                { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TLOOP;} }
break                                               { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TBREAK;} }
cont                                                { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TCONT;} }
var                                                 { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TVAR;} }
not                                                 { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TNOT;} }
and                                                 { {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return TAND;} }
{HEXPREFIX}{HEXDIGIT}+                              {yyyGenLeaf(1,1,yyyLRCIL+0,yyyLRCIL+1);(((yyyP1)(yyyTermBuffer.snBufPtr))->value) = convertHex(yytext); return number;} 
{DIGIT}+                                            {yyyGenLeaf(1,1,yyyLRCIL+0,yyyLRCIL+1);(((yyyP1)(yyyTermBuffer.snBufPtr))->value) = atoi(yytext); return number;} 
{ID}                                                {yyyGenLeaf(1,2,yyyLRCIL+1,yyyLRCIL+2); (((yyyP2)(yyyTermBuffer.snBufPtr))->sym) = single2(strdup(yytext), yylineno);return id;} 
"("                                                 { /*printf("lparen\n");            */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return '(';}}
")"                                                 { /*printf("rparen\n");            */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return ')';}}
","                                                 { /*printf("comma\n");             */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return ',';}}
";"                                                 { /*printf("semicolon\n");         */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return ';';}}
":"                                                 { /*printf("colon\n");             */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return ':';}}
":="                                                { /*printf("assignment\n");        */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return assignment;}}
"*"                                                 { /*printf("times\n");             */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return '*';}}
"-"                                                 { /*printf("minus\n");             */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return '-';}}
"+"                                                 { /*printf("plus\n");              */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return '+';}}
"<="                                                { /*printf("smallerThan\n");       */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return lessThan;}}
"#"                                                 { /*printf("#\n");                 */ {yyyGenLeaf(0,0,yyyLRCIL+2,yyyLRCIL+2);return '#';} }
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