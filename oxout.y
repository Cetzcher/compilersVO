/* output from Ox version G1.04 */
%{
%}
%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char* );
    #include "scope.h"
    yydebug = 1;
%}

%token TIF
%token TTHEN
%token TELSE
%token TEND
%token TRETURN
%token TLOOP
%token TBREAK
%token TCONT
%token TVAR
%token TNOT
%token TAND
%token TPROC

%token id
%token number
%token lessThan     /* <= */
%token assignment   /* := */






 
      
    



%{


struct yyyT1 { SymbolTree* sym;}; 
typedef struct yyyT1 *yyyP1; 


struct yyyT2 {SymbolTree* ids;}; 
typedef struct yyyT2 *yyyP2; 


struct yyyT3 { SymbolTree* context; SymbolTree* inherited; }; 
typedef struct yyyT3 *yyyP3; 
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

%{
#include <stdio.h>

int yyyYok = 1;
int yyyInitDone = 0;
char *yyySTsn;
yyyGNT *yyySTN;
int yyyGNSz = sizeof(yyyGNT);
int yyyProdNum,yyyRHSlength,yyyNattrbs,yyyTypeNum; 

extern yyyFT yyyRCIL[];

void yyyExecuteRRsection();
void yyyYoxInit();
void yyyYoxReset();
void yyyDecorate();
void yyyGenIntNode();
void yyyAdjustINRC();
void yyyPrune();
void yyyUnsolvedInstSearchTrav();
void yyyUnsolvedInstSearchTravAux();
void yyyerror();
void yyyShift();



#define yyyRSU(NUM1,NUM2,NUM3,NUM4) \
   yyyProdNum=NUM1;yyyRHSlength=NUM2;yyyNattrbs=NUM3;yyyTypeNum=NUM4;\
   if ((yychar <= 0) && (!yyyTermBuffer.isEmpty)) yyyShift(); 
%}


%%

yyyAugNonterm 
	:	{if (!yyyInitDone) 
		    {yyyYoxInit(); 
		     yyyInitDone = 1;
		    }
		 yyyYoxReset();
		}
		Program
		{
		 yyyDecorate(); yyyExecuteRRsection();
		}
	;
Program: FuncList {if(yyyYok){
yyyRSU(1,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+3);/*yyyPrune(1);*/}}
    ;

FuncList:
    Funcdef
    {if(yyyYok){
yyyRSU(2,1,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+3,yyyRCIL+9);}}
    | FuncList  Funcdef
    {if(yyyYok){
yyyRSU(3,2,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+9,yyyRCIL+18);}}
    ;

Funcdef: id '(' ArgList ')' StmtList TEND  ';'
    {if(yyyYok){
yyyRSU(4,7,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+18,yyyRCIL+24);}}
    ;

ArgList:       /* empty */  {if(yyyYok){
yyyRSU(5,0,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->ids) = single("!Meta"); yyyAdjustINRC(yyyRCIL+24,yyyRCIL+27);}}
    | id                    {if(yyyYok){
yyyRSU(6,1,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->ids) = addChild(newTree("!Meta"), (((yyyP1)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym)); yyyAdjustINRC(yyyRCIL+27,yyyRCIL+30);/*yyyPrune(6);*/}}
    | ArgList ',' id        {if(yyyYok){
yyyRSU(7,3,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+30,yyyRCIL+33);/*yyyPrune(7);*/}}
    ;

StmtList: Stmt ';'
    {if(yyyYok){
yyyRSU(8,2,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+33,yyyRCIL+39);/*yyyPrune(8);*/}}
    | StmtList Stmt ';'
    {if(yyyYok){
yyyRSU(9,3,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+39,yyyRCIL+48);/*yyyPrune(9);*/}}
    ; 

Stmt: TVAR id assignment Expression         
    {if(yyyYok){
yyyRSU(10,4,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->context) = (((yyyP1)(((char *)((yyySTN->cL)[1]))+yyyGNSz))->sym); 
        yyyAdjustINRC(yyyRCIL+48,yyyRCIL+51);/*yyyPrune(10);*/}}
    | id assignment Expression          
    {if(yyyYok){
yyyRSU(11,3,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->context) = addChild(metaNode(Assignment), (((yyyP1)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym)); 
        /*we add the id as a pseudo node this way it is actually in the tree and we can perform a lookup on traversal */ 
        yyyAdjustINRC(yyyRCIL+51,yyyRCIL+54);/*yyyPrune(11);*/}}
    | TIF Expression TTHEN StmtList TEND
    {if(yyyYok){
yyyRSU(12,5,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+54,yyyRCIL+60);}}
    | TIF Expression TTHEN StmtList TELSE StmtList TEND
    {if(yyyYok){
yyyRSU(13,7,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+60,yyyRCIL+69);}}
    | id ':' TLOOP StmtList TEND
    {if(yyyYok){
yyyRSU(14,5,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+69,yyyRCIL+75);}}
    | TBREAK id
    {if(yyyYok){
yyyRSU(15,2,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->context) = loopRefNode((((yyyP1)(((char *)((yyySTN->cL)[1]))+yyyGNSz))->sym));
        /*we need to validate that id is actually a loop and that this statement is within the loop body*/
        yyyAdjustINRC(yyyRCIL+75,yyyRCIL+78);/*yyyPrune(15);*/}}
    | TCONT id
    {if(yyyYok){
yyyRSU(16,2,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->context) = loopRefNode((((yyyP1)(((char *)((yyySTN->cL)[1]))+yyyGNSz))->sym));
        yyyAdjustINRC(yyyRCIL+78,yyyRCIL+81);/*yyyPrune(16);*/}}
    | '*' Term assignment Expression
    {if(yyyYok){
yyyRSU(17,4,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->context) = metaNode(Assignment);
        yyyAdjustINRC(yyyRCIL+81,yyyRCIL+84);/*yyyPrune(17);*/}}
    | Expression                        
    {if(yyyYok){
yyyRSU(18,1,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+84,yyyRCIL+87);/*yyyPrune(18);*/}}
    | TRETURN Expression
    {if(yyyYok){
yyyRSU(19,2,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->context) = returnNode();
        yyyAdjustINRC(yyyRCIL+87,yyyRCIL+90);/*yyyPrune(19);*/}}
    ;


BinaryOperator: '+' {if(yyyYok){
yyyRSU(20,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+90,yyyRCIL+90);/*yyyPrune(20);*/}}| '-' {if(yyyYok){
yyyRSU(21,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+90,yyyRCIL+90);/*yyyPrune(21);*/}}| lessThan {if(yyyYok){
yyyRSU(22,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+90,yyyRCIL+90);/*yyyPrune(22);*/}}| '#' {if(yyyYok){
yyyRSU(23,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+90,yyyRCIL+90);/*yyyPrune(23);*/}}| TAND
    {if(yyyYok){
yyyRSU(24,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+90,yyyRCIL+90);/*yyyPrune(24);*/}};

Expression:                                     
      Prefix Term
    {if(yyyYok){
yyyRSU(25,2,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+90,yyyRCIL+93);/*yyyPrune(25);*/}}| Expression BinaryOperator Term           {if(yyyYok){
yyyRSU(26,3,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+93,yyyRCIL+96);/*yyyPrune(26);*/}}
    ;

Prefix:  
    {if(yyyYok){
yyyRSU(27,0,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+96,yyyRCIL+96);}}| TNOT 
    {if(yyyYok){
yyyRSU(28,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+96,yyyRCIL+96);/*yyyPrune(28);*/}}| '*' 
    {if(yyyYok){
yyyRSU(29,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+96,yyyRCIL+96);/*yyyPrune(29);*/}}| '-'
    {if(yyyYok){
yyyRSU(30,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+96,yyyRCIL+96);/*yyyPrune(30);*/}};

CallArgs:                       {if(yyyYok){
yyyRSU(31,0,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->ids) = single("!CallArgs"); yyyAdjustINRC(yyyRCIL+96,yyyRCIL+99);}}
    | Expression                {if(yyyYok){
yyyRSU(32,1,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+99,yyyRCIL+102);/*yyyPrune(32);*/}}
    | CallArgs ',' Expression   {if(yyyYok){
yyyRSU(33,3,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+102,yyyRCIL+105);/*yyyPrune(33);*/}}
    ;

Call: id '(' CallArgs ')'   {if(yyyYok){
yyyRSU(34,4,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+105,yyyRCIL+108);/*yyyPrune(34);*/}}
    ;

Term: 
    Factor
    {if(yyyYok){
yyyRSU(35,1,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+108,yyyRCIL+111);/*yyyPrune(35);*/}}| Call
    {if(yyyYok){
yyyRSU(36,1,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+111,yyyRCIL+114);/*yyyPrune(36);*/}}| Term '*' Factor   
    {if(yyyYok){
yyyRSU(37,3,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+114,yyyRCIL+117);/*yyyPrune(37);*/}}
    ;
 
Factor: 
    number                  {if(yyyYok){
yyyRSU(38,1,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->ids) = single("!number node"); yyyAdjustINRC(yyyRCIL+117,yyyRCIL+120);/*yyyPrune(38);*/}}
    | '(' Expression ')'    
    {if(yyyYok){
yyyRSU(39,3,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+120,yyyRCIL+123);/*yyyPrune(39);*/}}| id                    {if(yyyYok){
yyyRSU(40,1,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->ids) = addChild(newTree("!Factors"), (((yyyP1)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym)); yyyAdjustINRC(yyyRCIL+123,yyyRCIL+126);/*yyyPrune(40);*/}}
    ; 


%%

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
    exit(2);
}
int main() {
    yyparse();
    printf(" *** Parsed programm *** \n");
    return 0;
}
                                                      /*custom*/  
long yyyMaxNbytesNodeStg = 2000000; 
long yyyMaxNrefCounts =    500000; 
long yyyMaxNchildren =     60000; 
long yyyMaxStackSize =     2000; 
long yyySSALspaceSize =    20000; 
long yyyRSmaxSize =        1000; 
long yyyTravStackMaxSize = 2000; 


struct yyyTB yyyTermBuffer; 

char *yyyNodeAndStackSpace; 

char *yyyNodeSpace;
char *yyyNextNodeSpace; 
char *yyyAfterNodeSpace; 


 
struct yyyGenNode **yyyChildListSpace;  
struct yyyGenNode **yyyNextCLspace; 
struct yyyGenNode **yyyAfterChildListSpace; 



yyyRCT *yyyRefCountListSpace;
yyyRCT *yyyNextRCLspace;  
yyyRCT *yyyAfterRefCountListSpace;   



struct yyySolvedSAlistCell {yyyWAT attrbNum; 
                            long next; 
                           }; 
#define yyyLambdaSSAL 0 
long yyySSALCfreeList = yyyLambdaSSAL; 
long yyyNewSSALC = 1; 
 
struct yyySolvedSAlistCell *yyySSALspace; 


 
struct yyyStackItem {struct yyyGenNode *node; 
                     long solvedSAlist; 
                     struct yyyGenNode *oldestNode; 
                    };  

long yyyNbytesStackStg; 
struct yyyStackItem *yyyStack; 
struct yyyStackItem *yyyAfterStack; 
struct yyyStackItem *yyyStackTop; 



struct yyyRSitem {yyyGNT *node; 
                  yyyWST whichSym; 
                  yyyWAT wa;  
                 };  

struct yyyRSitem *yyyRS;  
struct yyyRSitem *yyyRSTop;  
struct yyyRSitem *yyyAfterRS;  
 





yyyFT yyyRCIL[] = {
0,1,1, yyyR,0,1, 0,1,1, yyyR,0,2, 0,1,1, 1,1,1, 
yyyR,0,2, 4,1,1, yyyR,0,0, yyyR,0,0, yyyR,0,1, yyyR,0,1, 
0,1,1, yyyR,0,2, 0,1,1, 1,1,1, yyyR,0,0, yyyR,0,0, 
yyyR,0,1, 3,1,1, yyyR,0,2, 3,1,1, 5,1,1, yyyR,0,1, 
3,1,1, yyyR,0,0, yyyR,0,0, yyyR,0,0, yyyR,0,1, yyyR,0,0, 
yyyR,0,1, yyyR,0,2, yyyR,0,0, yyyR,0,1, yyyR,0,2, yyyR,0,1, 
yyyR,0,1, yyyR,0,1, yyyR,0,2, yyyR,0,0, yyyR,0,1, yyyR,0,0, 

};

short yyyIIIEL[] = {0,
0,2,4,7,15,16,18,22,25,29,
34,38,44,52,58,61,64,69,71,74,
76,78,80,82,84,87,91,92,94,96,
98,99,101,105,110,112,114,118,120,124,

};

long yyyIIEL[] = {
0,0,2,4,6,8,10,12,14,15,15,16,
16,18,18,18,19,20,21,22,23,23,24,26,
28,28,30,32,34,34,36,36,37,37,38,40,
41,41,42,44,44,45,45,47,47,49,49,50,
50,52,52,54,54,56,57,57,57,59,59,61,
61,62,64,64,65,67,67,68,68,69,71,72,
74,74,75,75,75,75,75,75,75,75,75,75,
75,76,76,77,78,79,79,80,80,80,80,80,
80,80,80,81,82,83,84,85,85,86,87,88,
88,89,89,90,91,92,93,94,95,95,96,97,
97,98,98,99,99,100,
};

long yyyIEL[] = {
0,2,2,2,4,6,6,6,
10,12,12,14,14,14,16,18,
20,22,22,22,22,24,24,26,
28,30,30,32,32,36,36,38,
38,40,40,40,40,42,42,42,
42,44,44,44,46,46,48,48,
48,52,52,54,54,56,56,56,
58,60,62,62,62,62,64,64,
64,66,66,66,66,66,66,66,
68,68,68,68,68,70,70,72,
74,74,74,76,76,78,80,80,
82,84,84,86,86,88,88,90,
92,92,92,94,94,96,
};

yyyFT yyyEntL[] = {
1,1,1,1,0,0,2,1,1,1,0,0,0,0,5,1,
0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,
1,1,2,1,0,0,0,0,0,0,0,0,4,1,0,0,
6,1,4,1,0,0,0,0,4,1,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

};

#define yyyPermitUserAlloc  0 


void yyyfatal(msg)
  char *msg; 
{fprintf(stderr,msg);exit(-1);} 



#define yyyNSof   'n' 
#define yyyRCof   'r' 
#define yyyCLof   'c' 
#define yyySof    's' 
#define yyySSALof 'S' 
#define yyyRSof   'q' 
#define yyyTSof   't' 



void yyyHandleOverflow(which) 
  char which; 
  {char *msg1,*msg2; 
   long  oldSize,newSize; 
   switch(which) 
     {
      case yyyNSof   : 
           msg1 = "node storage overflow: ";
           oldSize = yyyMaxNbytesNodeStg; 
           break; 
      case yyyRCof   : 
           msg1 = "dependee count overflow: ";
           oldSize = yyyMaxNrefCounts; 
           break; 
      case yyyCLof   : 
           msg1 = "child list overflow: ";
           oldSize = yyyMaxNchildren; 
           break; 
      case yyySof    : 
           msg1 = "parse-tree stack overflow: ";
           oldSize = yyyMaxStackSize; 
           break; 
      case yyySSALof : 
           msg1 = "SSAL overflow: ";
           oldSize = yyySSALspaceSize; 
           break; 
      case yyyRSof   : 
           msg1 = "ready set overflow: ";
           oldSize = yyyRSmaxSize; 
           break; 
      case yyyTSof   : 
           msg1 = "traversal stack overflow: ";
           oldSize = yyyTravStackMaxSize; 
           break; 
      default        :;  
     }
   newSize = (3*oldSize)/2; 
   if (newSize < 100) newSize = 100; 
   fprintf(stderr,msg1); 
   fprintf(stderr,"size was %d.\n",oldSize); 
   if (yyyPermitUserAlloc) 
      msg2 = "     Try -Y%c%d option.\n"; 
      else 
      msg2 = "     Have to modify evaluator:  -Y%c%d.\n"; 
   fprintf(stderr,msg2,which,newSize); 
   exit(-1); 
  }



void yyySignalEnts(node,startP,stopP) 
  register yyyGNT *node; 
  register yyyFT *startP,*stopP;  
  {register yyyGNT *dumNode; 

   while (startP < stopP)  
     {
      if (!(*startP)) dumNode = node;  
         else dumNode = (node->cL)[(*startP)-1];   
      if (!(--((dumNode->refCountList)[*(startP+1)]
              ) 
           )
         ) 
         { 
          if (++yyyRSTop == yyyAfterRS) 
             {yyyHandleOverflow(yyyRSof); 
              break; 
             }
          yyyRSTop->node = dumNode; 
          yyyRSTop->whichSym = *startP;  
          yyyRSTop->wa = *(startP+1);  
         }  
      startP += 2;  
     }  
  } 




#define yyyCeiling(num,inc) (((inc) * ((num)/(inc))) + (((num)%(inc))?(inc):0)) 



int yyyAlignSize = 4;
int yyyNdSz[4];

int yyyNdPrSz[4];

typedef int yyyCopyType;

int yyyNdCopySz[4];
long yyyBiggestNodeSize = 0;

void yyyNodeSizeCalc()
  {int i;
   yyyGNSz = yyyCeiling(yyyGNSz,yyyAlignSize); 
   yyyNdSz[0] = 0;
   yyyNdSz[1] = sizeof(struct yyyT1);
   yyyNdSz[2] = sizeof(struct yyyT2);
   yyyNdSz[3] = sizeof(struct yyyT3);
   for (i=0;i<4;i++) 
       {yyyNdSz[i] = yyyCeiling(yyyNdSz[i],yyyAlignSize); 
        yyyNdPrSz[i] = yyyNdSz[i] + yyyGNSz;
        if (yyyBiggestNodeSize < yyyNdSz[i])
           yyyBiggestNodeSize = yyyNdSz[i];
        yyyNdCopySz[i] = yyyCeiling(yyyNdSz[i],sizeof(yyyCopyType)) / 
                         sizeof(yyyCopyType); 
       }
  }




void yyySolveAndSignal() {
register long yyyiDum,*yyypL;
register int yyyws,yyywa;
register yyyGNT *yyyRSTopN,*yyyRefN; 
register void *yyyRSTopNp; 


yyyRSTopNp = (yyyRSTopN = yyyRSTop->node)->parent;
yyyRefN= (yyyws = (yyyRSTop->whichSym))?((yyyGNT *)yyyRSTopNp):yyyRSTopN;
yyywa = yyyRSTop->wa; 
yyyRSTop--;
switch(yyyRefN->prodNum) {
case 1:  /***yacc rule 1***/
  switch (yyyws) {
  case 1:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context);     break;
    }
  break;
  }
break;
case 2:  /***yacc rule 2***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChild(newTree("!root"), validate((((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context)));
        break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 3:  /***yacc rule 3***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = validate(addChild((((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context), (((yyyP3)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->context)));
        
        break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 4:  /***yacc rule 4***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChildren(addChildren((((yyyP1)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->sym), (((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids)), (((yyyP3)(((char *)((yyyRefN->cL)[4]))+yyyGNSz))->context));
        break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  case 5:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 5:  /***yacc rule 5***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 6:  /***yacc rule 6***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 7:  /***yacc rule 7***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = addChild((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP1)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->sym));     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 8:  /***yacc rule 8***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChild(metaNode(Statement), (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context));
            yyySignalEnts(yyyRefN,yyyEntL+28,yyyEntL+30);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->context); 
        break;
    }
  break;
  }
break;
case 9:  /***yacc rule 9***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChild((((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context), (((yyyP3)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->context));
            yyySignalEnts(yyyRefN,yyyEntL+32,yyyEntL+36);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->context);  
        break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->context);
            break;
    }
  break;
  }
break;
case 10:  /***yacc rule 10***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 11:  /***yacc rule 11***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 12:  /***yacc rule 12***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = (((yyyP3)(((char *)((yyyRefN->cL)[3]))+yyyGNSz))->context);
            break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 13:  /***yacc rule 13***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChild(addChild(metaNode(If), (((yyyP3)(((char *)((yyyRefN->cL)[3]))+yyyGNSz))->context)), (((yyyP3)(((char *)((yyyRefN->cL)[5]))+yyyGNSz))->context));
            break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  case 6:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 14:  /***yacc rule 14***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChildren(loopNode((((yyyP1)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->sym)), (((yyyP3)(((char *)((yyyRefN->cL)[3]))+yyyGNSz))->context));
        break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    case 1:
(((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 15:  /***yacc rule 15***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 16:  /***yacc rule 16***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 17:  /***yacc rule 17***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 18:  /***yacc rule 18***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->context) = metaNode(ExpressionStatement), (((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids); 
            break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 19:  /***yacc rule 19***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 20:  /***yacc rule 20***/
  switch (yyyws) {
  }
break;
case 21:  /***yacc rule 21***/
  switch (yyyws) {
  }
break;
case 22:  /***yacc rule 22***/
  switch (yyyws) {
  }
break;
case 23:  /***yacc rule 23***/
  switch (yyyws) {
  }
break;
case 24:  /***yacc rule 24***/
  switch (yyyws) {
  }
break;
case 25:  /***yacc rule 25***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP2)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 26:  /***yacc rule 26***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = addChildrenMode((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids), FALSE);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 27:  /***yacc rule 27***/
  switch (yyyws) {
  }
break;
case 28:  /***yacc rule 28***/
  switch (yyyws) {
  }
break;
case 29:  /***yacc rule 29***/
  switch (yyyws) {
  }
break;
case 30:  /***yacc rule 30***/
  switch (yyyws) {
  }
break;
case 31:  /***yacc rule 31***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 32:  /***yacc rule 32***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 33:  /***yacc rule 33***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = addChildrenMode((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids), FALSE);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 34:  /***yacc rule 34***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = addChildrenMode(addChild(newTree("!Call"), (((yyyP1)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->sym)), (((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids), FALSE);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 35:  /***yacc rule 35***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 36:  /***yacc rule 36***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 37:  /***yacc rule 37***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = addChildrenMode((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids), FALSE); 
        break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 38:  /***yacc rule 38***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 39:  /***yacc rule 39***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP2)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 40:  /***yacc rule 40***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
} /* switch */ 

if (yyyws)  /* the just-solved instance was inherited. */ 
   {if (yyyRSTopN->prodNum) 
       {yyyiDum = yyyIIEL[yyyIIIEL[yyyRSTopN->prodNum]] + yyywa;
        yyySignalEnts(yyyRSTopN,yyyEntL + yyyIEL[yyyiDum],
                                yyyEntL + yyyIEL[yyyiDum+1]
                     );
       }
   } 
   else     /* the just-solved instance was synthesized. */ 
   {if ((char *)yyyRSTopNp >= yyyNodeSpace) /* node has a parent. */ 
       {yyyiDum = yyyIIEL[yyyIIIEL[((yyyGNT *)yyyRSTopNp)->prodNum] + 
                          yyyRSTopN->whichSym 
                         ] + 
                  yyywa;
        yyySignalEnts((yyyGNT *)yyyRSTopNp,
                      yyyEntL + yyyIEL[yyyiDum],
                      yyyEntL + yyyIEL[yyyiDum+1] 
                     );
       } 
       else   /* node is still on the stack--it has no parent yet. */ 
       {yyypL = &(((struct yyyStackItem *)yyyRSTopNp)->solvedSAlist); 
        if (yyySSALCfreeList == yyyLambdaSSAL) 
           {yyySSALspace[yyyNewSSALC].next = *yyypL; 
            if ((*yyypL = yyyNewSSALC++) == yyySSALspaceSize) 
               yyyHandleOverflow(yyySSALof); 
           }  
           else
           {yyyiDum = yyySSALCfreeList; 
            yyySSALCfreeList = yyySSALspace[yyySSALCfreeList].next; 
            yyySSALspace[yyyiDum].next = *yyypL; 
            *yyypL = yyyiDum;  
           } 
        yyySSALspace[*yyypL].attrbNum = yyywa; 
       } 
   }

} /* yyySolveAndSignal */ 






#define condStg unsigned int conds;
#define yyyClearConds {yyyTST->conds = 0;}
#define yyySetCond(n) {yyyTST->conds += (1<<(n));}
#define yyyCond(n) ((yyyTST->conds & (1<<(n)))?1:0)



struct yyyTravStackItem {yyyGNT *node; 
                         char isReady;
                         condStg
                        };



void yyyDoTraversals()
{struct yyyTravStackItem *yyyTravStack,*yyyTST,*yyyAfterTravStack;
 register yyyGNT *yyyTSTn,**yyyCLptr1,**yyyCLptr2; 
 register int yyyi,yyyRL,yyyPass;

 if (!yyyYok) return;
 if ((yyyTravStack = 
                 ((struct yyyTravStackItem *) 
                  malloc((yyyTravStackMaxSize * 
                                  sizeof(struct yyyTravStackItem)
                                 )
                        )
                 )
     )
     == 
     (struct yyyTravStackItem *)NULL
    ) 
    {fprintf(stderr,"malloc error in traversal stack allocation\n"); 
     exit(-1); 
    } 

yyyAfterTravStack = yyyTravStack + yyyTravStackMaxSize; 
yyyTravStack++; 


for (yyyi=0; yyyi<1; yyyi++) {
yyyTST = yyyTravStack; 
yyyTST->node = yyyStack->node;
yyyTST->isReady = 0;
yyyClearConds

while(yyyTST >= yyyTravStack)
  {yyyTSTn = yyyTST->node;
   if (yyyTST->isReady)  
      {yyyPass = 1;
       goto yyyTravSwitch;
yyyTpop:
       yyyTST--;
      } 
      else 
      {yyyPass = 0;
       goto yyyTravSwitch;
yyyTpush:
       yyyTST->isReady = 1;  
       if (yyyTSTn->prodNum)
          if (yyyRL)
             {yyyCLptr2 = yyyTSTn->cL; 
              while 
                ((yyyCLptr2 != yyyNextCLspace)
                 &&
                 ((*yyyCLptr2)->parent == yyyTSTn) 
                )  
                {if (++yyyTST == yyyAfterTravStack)
                    yyyHandleOverflow(yyyTSof);
                    else
                    {yyyTST->node = *yyyCLptr2; 
                     yyyTST->isReady = 0; 
                     yyyClearConds
                    }
                 yyyCLptr2++; 
                } 
             } /* right to left */
             else  /* left to right */
             {yyyCLptr1 = yyyCLptr2 = yyyTSTn->cL; 
              while 
                ((yyyCLptr2 != yyyNextCLspace)
                 &&
                 ((*yyyCLptr2)->parent == yyyTSTn) 
                )  
                yyyCLptr2++; 
              while (yyyCLptr2-- > yyyCLptr1)
                if (++yyyTST == yyyAfterTravStack)
                   yyyHandleOverflow(yyyTSof);
                   else
                   {yyyTST->node = *yyyCLptr2; 
                    yyyTST->isReady = 0; 
                    yyyClearConds
                   }
             } /* left to right */
      } /* else */
   continue;
yyyTravSwitch:
				switch(yyyTSTn->prodNum)	{
case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { debugSymTree((((yyyP3)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->context), 0); }
				break;
					}

break;
case 2:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 3:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 4:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 5:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 6:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 7:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 8:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 9:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 10:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP1)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym), (((yyyP2)(((char *)((yyyTSTn->cL)[3]))+yyyGNSz))->ids));
    }
				break;
					}

break;
case 11:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { { checkDeclared((((yyyP1)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)->parent, (((yyyP1)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)->var);   checkSubtreeDeclared((((yyyP1)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)->parent, (((yyyP2)(((char *)((yyyTSTn->cL)[2]))+yyyGNSz))->ids)); } /* we look above the pseudo node, we also validate expression */
    }
				break;
					}

break;
case 12:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->ids));
    }
				break;
					}

break;
case 13:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->ids));
    }
				break;
					}

break;
case 14:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 15:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkLooprefCorrect((((yyyP1)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym)); 
    }
				break;
					}

break;
case 16:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkLooprefCorrect((((yyyP1)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym)); 
    }
				break;
					}

break;
case 17:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { {checkSubtreeDeclared((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->ids)); checkSubtreeDeclared((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP2)(((char *)((yyyTSTn->cL)[3]))+yyyGNSz))->ids)); }
    }
				break;
					}

break;
case 18:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->ids));
        /* all children of stmt must be declared before use */
    }
				break;
					}

break;
case 19:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->ids));
    }
				break;
					}

break;
case 20:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 21:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 22:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 23:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 24:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 25:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 26:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 27:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 28:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 29:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 30:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 31:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 32:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 33:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 34:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 35:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 36:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 37:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 38:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 39:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
case 40:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}

break;
								} /* switch */ 
   if (yyyPass) goto yyyTpop; else goto yyyTpush; 
  } /* while */ 
 } /* for */ 
} /* yyyDoTraversals */ 

void yyyExecuteRRsection()  {
   int yyyi; 
   long yyynRefCounts; 
   long cycleSum = 0;
   long nNZrc = 0;

   if (!yyyYok) return; 
   yyynRefCounts = yyyNextRCLspace - yyyRefCountListSpace; 
   for (yyyi=0;yyyi<yyynRefCounts;yyyi++) 
     if (yyyRefCountListSpace[yyyi])
        {cycleSum += yyyRefCountListSpace[yyyi]; nNZrc++;} 
   if (nNZrc) 
      {
       fprintf(stderr,"\n\n\n**********\n");
       fprintf(stderr,
               "cycle detected in completed parse tree");
       fprintf(stderr,
               " after decoration.\n");
       fprintf(stderr,
         "searching parse tree for %d unsolved instances:\n",
               nNZrc
              );
       yyyUnsolvedInstSearchTravAux(yyyStackTop->node);
      }
   yyyDoTraversals();
} /* yyyExecuteRRsection */ 



yyyWAT yyyLRCIL[1] = {0,
};



void yyyYoxInit()                                  /*stock*/  
  { 

   yyyNodeSizeCalc(); 

   if ((yyyTermBuffer.snBufPtr = 
        (char *) malloc((yyyBiggestNodeSize + sizeof(yyyCopyType)))
       )  
       == 
       ((char *) NULL) 
      )   
      yyyfatal("malloc error in yyyTermBuffer allocation\n");  
  
  
   yyyNbytesStackStg = yyyMaxStackSize*sizeof(struct yyyStackItem); 
   yyyNbytesStackStg = ((yyyNbytesStackStg/yyyAlignSize)+1)*yyyAlignSize;  
   if ((yyyNodeAndStackSpace = 
        (char *) malloc((yyyNbytesStackStg + 
                                 yyyMaxNbytesNodeStg + 
                                 yyyGNSz + 
                                 yyyBiggestNodeSize + 
                                 sizeof(yyyCopyType) 
                                )
                       )
       )  
       == 
       ((char *) NULL) 
      )   
      yyyfatal("malloc error in ox node and stack space allocation\n");
   yyyStack = (struct yyyStackItem *) yyyNodeAndStackSpace; 
   yyyAfterStack = yyyStack + yyyMaxStackSize;  
   yyyNodeSpace = yyyNodeAndStackSpace + yyyNbytesStackStg;
   yyyAfterNodeSpace = yyyNodeSpace + yyyMaxNbytesNodeStg;
 
 
   if ((yyyRS = (struct yyyRSitem *) 
         malloc(((yyyRSmaxSize+1)*sizeof(struct yyyRSitem)))
       )  
       == 
       ((struct yyyRSitem *) NULL) 
      )   
      yyyfatal("malloc error in ox ready set space allocation\n");  
   yyyRS++; 
   yyyAfterRS = yyyRS + yyyRSmaxSize; 

 
   if ((yyyChildListSpace = 
        (yyyGNT **) malloc((yyyMaxNchildren*sizeof(yyyGNT *)))
       )  
       == 
       ((yyyGNT **) NULL) 
      )   
      yyyfatal("malloc error in ox child list space allocation\n");  
   yyyAfterChildListSpace = yyyChildListSpace + yyyMaxNchildren; 

 
   if ((yyyRefCountListSpace = 
        (yyyRCT *) malloc((yyyMaxNrefCounts * sizeof(yyyRCT)))
       )  
       == 
       ((yyyRCT *) NULL) 
      )   
      yyyfatal("malloc error in ox reference count list space allocation\n");  
   yyyAfterRefCountListSpace = yyyRefCountListSpace + yyyMaxNrefCounts;  
  
 
   if ((yyySSALspace = (struct yyySolvedSAlistCell *) 
          malloc(((yyySSALspaceSize+1) * 
                          sizeof(struct yyySolvedSAlistCell))
                         ) 
       ) 
       == 
       ((struct yyySolvedSAlistCell *) NULL) 
      ) 
      yyyfatal("malloc error in stack solved list space allocation\n"); 
  } /* yyyYoxInit */ 



void yyyYoxReset() 
  { 
   yyyTermBuffer.isEmpty = 1; 
   yyyStackTop = yyyStack; 
   while (yyyStackTop != yyyAfterStack) 
     (yyyStackTop++)->solvedSAlist = yyyLambdaSSAL; 
   yyyStackTop = yyyStack - 1; 
   yyyNextNodeSpace = yyyNodeSpace; 
   yyyRSTop = yyyRS - 1; 
   yyyNextCLspace = yyyChildListSpace;
   yyyNextRCLspace = yyyRefCountListSpace; 
  }  



void yyyDecorate() 
  { 
   while (yyyRSTop >= yyyRS) 
      yyySolveAndSignal();  
  } 



void yyyShift() 
  {yyyRCT *rcPdum; 
   register yyyCopyType *CTp1,*CTp2,*CTp3; 
   register yyyWAT *startP,*stopP;  

   if ((++yyyStackTop) == yyyAfterStack) 
      yyyHandleOverflow(yyySof);
   CTp2 = (yyyCopyType *)(yyyStackTop->oldestNode = 
                          yyyStackTop->node = 
                          (yyyGNT *)yyyNextNodeSpace 
                         ); 
   yyyTermBuffer.isEmpty = 1;
   ((yyyGNT *)CTp2)->parent = (void *)yyyStackTop; 
   ((yyyGNT *)CTp2)->cL = yyyNextCLspace;  
   rcPdum = ((yyyGNT *)CTp2)->refCountList = yyyNextRCLspace;  
   ((yyyGNT *)CTp2)->prodNum = 0; 
   if ((yyyNextRCLspace += yyyTermBuffer.nAttrbs) 
       > 
       yyyAfterRefCountListSpace 
      ) 
      yyyHandleOverflow(yyyRCof); 
   startP = yyyTermBuffer.startP;  
   stopP = yyyTermBuffer.stopP;  
   while (startP < stopP) rcPdum[*(startP++)] = 0; 
   if ((yyyNextNodeSpace += yyyNdPrSz[yyyTermBuffer.typeNum]) 
       > 
       yyyAfterNodeSpace 
      ) 
      yyyHandleOverflow(yyyNSof);  
   CTp1 = (yyyCopyType *)(yyyTermBuffer.snBufPtr); 
   CTp2 = (yyyCopyType *)(((char *)CTp2) + yyyGNSz); 
   CTp3 = CTp2 + yyyNdCopySz[yyyTermBuffer.typeNum]; 
   while (CTp2 < CTp3) *CTp2++ = *CTp1++; 
  } 



void yyyGenIntNode() 
  {register yyyWST i;
   register struct yyyStackItem *stDum;  
   register yyyGNT *gnpDum; 

   if ((stDum = (yyyStackTop -= (yyyRHSlength-1))) >= yyyAfterStack) 
      yyyHandleOverflow(yyySof);
   yyySTsn = ((char *)(yyySTN = (yyyGNT *)yyyNextNodeSpace)) + yyyGNSz; 
   yyySTN->parent       =  (void *)yyyStackTop;  
   yyySTN->cL           =  yyyNextCLspace; 
   yyySTN->refCountList =  yyyNextRCLspace; 
   yyySTN->prodNum      =  yyyProdNum; 
   if ((yyyNextCLspace+yyyRHSlength) > yyyAfterChildListSpace) 
      yyyHandleOverflow(yyyCLof); 
   for (i=1;i<=yyyRHSlength;i++) 
     {gnpDum = *(yyyNextCLspace++) = (stDum++)->node;  
      gnpDum->whichSym = i;  
      gnpDum->parent = (void *)yyyNextNodeSpace; 
     } 
   if ((yyyNextRCLspace += yyyNattrbs) > yyyAfterRefCountListSpace) 
      yyyHandleOverflow(yyyRCof); 
   if ((yyyNextNodeSpace += yyyNdPrSz[yyyTypeNum]) > yyyAfterNodeSpace) 
      yyyHandleOverflow(yyyNSof);  
  } 



#define yyyDECORfREQ 50 



void yyyAdjustINRC(startP,stopP) 
  register yyyFT *startP,*stopP;
  {yyyWST i;
   long SSALptr,SSALptrHead,*cPtrPtr; 
   long *pL; 
   struct yyyStackItem *stDum;  
   yyyGNT *gnpDum; 
   long iTemp;
   register yyyFT *nextP;
   static unsigned short intNodeCount = yyyDECORfREQ;

   nextP = startP;
   while (nextP < stopP) 
     {if ((*nextP) == yyyR)  
         {(yyySTN->refCountList)[*(nextP+1)] = *(nextP+2);
         } 
         else 
         {(((yyySTN->cL)[*nextP])->refCountList)[*(nextP+1)] = *(nextP+2);
         } 
      nextP += 3;  
     }
   pL = yyyIIEL + yyyIIIEL[yyyProdNum]; 
   stDum = yyyStackTop;  
   for (i=1;i<=yyyRHSlength;i++) 
     {pL++; 
      SSALptrHead = SSALptr = *(cPtrPtr = &((stDum++)->solvedSAlist)); 
      if (SSALptr != yyyLambdaSSAL) 
         {*cPtrPtr = yyyLambdaSSAL; 
          do 
            {
             iTemp = (*pL+yyySSALspace[SSALptr].attrbNum);
             yyySignalEnts(yyySTN,
                           yyyEntL + yyyIEL[iTemp],
                           yyyEntL + yyyIEL[iTemp+1]
                          );  
             SSALptr = *(cPtrPtr = &(yyySSALspace[SSALptr].next)); 
            } 
            while (SSALptr != yyyLambdaSSAL);  
          *cPtrPtr = yyySSALCfreeList;  
          yyySSALCfreeList = SSALptrHead;  
         } 
     } 
   nextP = startP + 2;
   while (nextP < stopP) 
     {if (!(*nextP))
         {if ((*(nextP-2)) == yyyR)  
             {pL = &(yyyStackTop->solvedSAlist); 
              if (yyySSALCfreeList == yyyLambdaSSAL) 
                 {yyySSALspace[yyyNewSSALC].next = *pL; 
                  if ((*pL = yyyNewSSALC++) == yyySSALspaceSize) 
                     yyyHandleOverflow(yyySSALof); 
                 }  
                 else
                 {iTemp = yyySSALCfreeList; 
                  yyySSALCfreeList = yyySSALspace[yyySSALCfreeList].next; 
                  yyySSALspace[iTemp].next = *pL; 
                  *pL = iTemp;  
                 } 
              yyySSALspace[*pL].attrbNum = *(nextP-1); 
             } 
             else 
             {if ((gnpDum = (yyySTN->cL)[*(nextP-2)])->prodNum != 0)
                 {
                  iTemp = yyyIIEL[yyyIIIEL[gnpDum->prodNum]] + *(nextP-1);
                  yyySignalEnts(gnpDum, 
                                yyyEntL + yyyIEL[iTemp],  
                                yyyEntL + yyyIEL[iTemp+1] 
                               );    
                 }  
             } 
         } 
      nextP += 3; 
     } 
   yyyStackTop->node = yyySTN;
   if (!yyyRHSlength) yyyStackTop->oldestNode = yyySTN; 
   if (!--intNodeCount) 
      {intNodeCount = yyyDECORfREQ; 
       yyyDecorate(); 
      } 
  } 



void yyyPrune(prodNum) 
  long prodNum;
  {  
   int i,n; 
   register char *cp1,*cp2;  
   register yyyRCT *rcp1,*rcp2,*rcp3;  
   long cycleSum = 0;
   long nNZrc = 0;
   yyyRCT *tempNextRCLspace;
   
   yyyDecorate();
   tempNextRCLspace = yyyNextRCLspace;
   yyyNextRCLspace = 
     (rcp1 = rcp2 = (yyyStackTop->oldestNode)->refCountList) + yyyNattrbs;
   rcp3 = (yyyStackTop->node)->refCountList; 
   while (rcp2 < rcp3) 
     if (*rcp2++) {cycleSum += *(rcp2 - 1); nNZrc++;} 
   if (nNZrc) 
      {
       fprintf(stderr,"\n\n\n----------\n");
       fprintf(stderr,
         "cycle detected during pruning of a subtree\n");
       fprintf(stderr,
         "  at whose root production %d is applied.\n",prodNum);
       yyyNextRCLspace = tempNextRCLspace; 
       fprintf(stderr,
         "prune aborted: searching subtree for %d unsolved instances:\n",
               nNZrc
              );
       yyyUnsolvedInstSearchTrav(yyyStackTop->node);
       return; 
      }
   for (i=0;i<yyyNattrbs;i++) rcp1[i] = rcp3[i]; 
   yyyNextCLspace = (yyyStackTop->oldestNode)->cL; 
   yyyNextNodeSpace = (char *)(yyyStackTop->oldestNode) + 
                      (n = yyyNdPrSz[yyyTypeNum]);
   cp1 = (char *)yyyStackTop->oldestNode; 
   cp2 = (char *)yyyStackTop->node; 
   for (i=0;i<n;i++) *cp1++ = *cp2++; 
   yyyStackTop->node = yyyStackTop->oldestNode; 
   (yyyStackTop->node)->refCountList = rcp1; 
   (yyyStackTop->node)->cL = yyyNextCLspace; 
  } 



void yyyGenLeaf(nAttrbs,typeNum,startP,stopP) 
  int nAttrbs,typeNum; 
  yyyWAT *startP,*stopP; 
  {
   if  (!(yyyTermBuffer.isEmpty)) yyyShift(); 
   yyyTermBuffer.isEmpty = 0;
   yyyTermBuffer.typeNum = typeNum; 
   yyyTermBuffer.nAttrbs = nAttrbs; 
   yyyTermBuffer.startP = startP; 
   yyyTermBuffer.stopP = stopP; 
   
  } 



void yyyerror()
  {yyyYok = 0; 
  } 



/* read the command line for changes in sizes of 
                  the evaluator's data structures */
void yyyCheckForResizes(argc,argv) 
  int argc; 
  char *argv[]; 
  {int i; 
   long dum; 
 
   if (!yyyPermitUserAlloc) return; 
   for (i=1;i<argc;i++) 
     { 
      if ((argv[i][0] != '-') || (argv[i][1] != 'Y')) continue; 
      if (strlen(argv[i]) < 4) goto yyyErrO1; 
      if (sscanf(argv[i]+3,"%d",&dum) != 1) goto yyyErrO1;
      if (dum < 2) dum = 2;
      switch (argv[i][2]) 
        {case yyyNSof:   yyyMaxNbytesNodeStg = dum; break; 
         case yyyRCof:   yyyMaxNrefCounts    = dum; break; 
         case yyyCLof:   yyyMaxNchildren     = dum; break; 
         case yyySof:    yyyMaxStackSize     = dum; break; 
         case yyySSALof: yyySSALspaceSize    = dum; break; 
         case yyyRSof:   yyyRSmaxSize        = dum; break; 
         case yyyTSof:   yyyTravStackMaxSize = dum; break; 
         default : goto yyyErrO1; 
        }
      continue;  
   yyyErrO1 : fprintf(stderr,"invalid command line option: %s\n",
                             argv[i] 
                     ); 
     } 
  } 
   
   
   


#define yyyLastProdNum 40


#define yyyNsorts 3


int yyyProdsInd[] = {
   0,
   0,   2,   4,   7,  15,  16,  18,  22,  25,  29,
  34,  38,  44,  52,  58,  61,  64,  69,  71,  74,
  76,  78,  80,  82,  84,  87,  91,  92,  94,  96,
  98,  99, 101, 105, 110, 112, 114, 118, 120, 124,
 126,
};


int yyyProds[][2] = {
{1013,   0},{ 844,   3},{ 844,   3},{ 165,   3},{ 844,   3},
{ 844,   3},{ 165,   3},{ 165,   3},{ 907,   1},{ 396,   0},
{ 814,   2},{ 404,   0},{ 849,   3},{ 612,   0},{ 548,   0},
{ 814,   2},{ 814,   2},{ 907,   1},{ 814,   2},{ 814,   2},
{ 428,   0},{ 907,   1},{ 849,   3},{ 235,   3},{ 548,   0},
{ 849,   3},{ 849,   3},{ 235,   3},{ 548,   0},{ 235,   3},
{1143,   0},{ 907,   1},{ 759,   0},{ 899,   2},{ 235,   3},
{ 907,   1},{ 759,   0},{ 899,   2},{ 235,   3},{ 227,   0},
{ 899,   2},{ 458,   0},{ 849,   3},{ 612,   0},{ 235,   3},
{ 227,   0},{ 899,   2},{ 458,   0},{ 849,   3},{ 775,   0},
{ 849,   3},{ 612,   0},{ 235,   3},{ 907,   1},{ 540,   0},
{ 718,   0},{ 849,   3},{ 612,   0},{ 235,   3},{ 537,   0},
{ 907,   1},{ 235,   3},{ 390,   0},{ 907,   1},{ 235,   3},
{ 412,   0},{ 997,   2},{ 759,   0},{ 899,   2},{ 235,   3},
{ 899,   2},{ 235,   3},{ 945,   0},{ 899,   2},{1036,   0},
{ 420,   0},{1036,   0},{ 436,   0},{1036,   0},{1002,   0},
{1036,   0},{ 356,   0},{1036,   0},{ 580,   0},{ 899,   2},
{ 888,   0},{ 997,   2},{ 899,   2},{ 899,   2},{1036,   0},
{ 997,   2},{ 888,   0},{ 888,   0},{ 989,   0},{ 888,   0},
{ 412,   0},{ 888,   0},{ 436,   0},{ 628,   2},{ 628,   2},
{ 899,   2},{ 628,   2},{ 628,   2},{ 428,   0},{ 899,   2},
{ 274,   2},{ 907,   1},{ 396,   0},{ 628,   2},{ 404,   0},
{ 997,   2},{ 968,   2},{ 997,   2},{ 274,   2},{ 997,   2},
{ 997,   2},{ 412,   0},{ 968,   2},{ 968,   2},{ 972,   0},
{ 968,   2},{ 396,   0},{ 899,   2},{ 404,   0},{ 968,   2},
{ 907,   1},
};


int yyySortsInd[] = {
  0,
  0,  1,  2,
  4,
};


int yyySorts[] = {
  676,  882,  922,   18,
};



char *yyyStringTab[] = {
0,0,0,0,0,
0,0,0,"debugSymTree",0,
0,0,0,"newTree",0,
0,0,0,"inherited",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"t",0,0,
0,0,"y",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"SymbolTree",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"Funcdef",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"TIF",0,0,
0,0,0,0,0,
"Stmt",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"Call",
0,0,0,0,0,
0,0,0,0,"validate",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"'#'",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"TCONT",0,0,0,0,
0,"'('",0,0,0,
0,0,0,0,"')'",
0,0,0,0,0,
0,0,"'*'",0,0,
0,"strdup",0,0,0,
"'+'",0,0,0,0,
0,0,0,"','",0,
0,0,0,0,0,
0,"'-'",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"TTHEN",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"single2",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"yylineno",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"TBREAK",0,0,
"':'",0,0,0,0,
0,0,0,"';'",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"addChildren",0,0,
0,0,0,0,0,
"TAND",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"TEND",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"parent",0,"CallArgs",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"sym",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"TLOOP","addChildrenMode",
0,0,0,0,0,
0,0,"Assignment",0,"FALSE",
0,0,"metaNode",0,0,
0,0,0,0,"returnNode",
0,0,0,0,0,
0,0,0,0,0,
0,0,"Statement",0,0,
0,0,0,0,"assignment",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"TELSE",0,0,0,0,
"ExpressionStatement",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"var",0,0,
0,"loopNode",0,0,"ArgList",
"loopRefNode",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"FuncList",
0,0,0,0,"StmtList",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"ids",0,0,
0,0,0,"Prefix",0,
0,"If",0,0,0,
0,0,0,0,"Expression",
0,0,0,0,0,
0,0,"id",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"context",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"TRETURN",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"Factor",0,
0,0,"number",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"TNOT",
0,0,0,0,0,
0,0,"Term",0,0,
0,0,"lessThan",0,0,
0,0,0,0,0,
0,0,0,"Program",0,
0,0,0,0,0,
0,0,0,"yytext",0,
0,0,0,0,0,
0,0,0,0,0,
0,"BinaryOperator",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"addChild",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"TVAR",0,
0,0,0,0,"TPROC",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"single",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"checkDeclared",
0,0,0,0,0,
"checkLooprefCorrect","checkSubtreeDeclared",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,
};



#define yyySizeofProd(num) (yyyProdsInd[(num)+1] - yyyProdsInd[(num)])

#define yyyGSoccurStr(prodNum,symPos) \
   (yyyStringTab[yyyProds[yyyProdsInd[(prodNum)] + (symPos)][0]])

#define yyySizeofSort(num) (yyySortsInd[(num)+1] - yyySortsInd[(num)])

#define yyySortOf(prodNum,symPos) \
  (yyyProds[yyyProdsInd[(prodNum)] + (symPos)][1]) 

#define yyyAttrbStr(prodNum,symPos,attrbNum)                      \
  (yyyStringTab[yyySorts[yyySortsInd[yyySortOf(prodNum,symPos)] + \
                         (attrbNum)                               \
                        ]                                         \
               ]                                                  \
  )



void yyyShowProd(i)
  int i;
  {int j,nSyms;

   nSyms = yyySizeofProd(i);
   for (j=0; j<nSyms; j++)
     {
      fprintf(stderr,"%s",yyyGSoccurStr(i,j));
      if (j == 0) fprintf(stderr," : "); else fprintf(stderr," ");
     }
   fprintf(stderr,";\n");
  }



void yyyShowProds()
  {int i; for (i=1; i<=yyyLastProdNum; i++) yyyShowProd(i);}



void yyyShowSymsAndSorts()
  {int i; 

   for (i=1; i<=yyyLastProdNum; i++) 
     {int j, nSyms;

      fprintf(stderr,
              "\n\n\n---------------------------------- %3.1d\n",i);
      /* yyyShowProd(i); */ 
      nSyms = yyySizeofProd(i); 
      for (j=0; j<nSyms; j++) 
        {int k, sortSize;

         fprintf(stderr,"%s\n",yyyGSoccurStr(i,j));
         sortSize = yyySizeofSort(yyySortOf(i,j));
         for (k=0; k<sortSize; k++) 
            fprintf(stderr,"  %s\n",yyyAttrbStr(i,j,k));
         if (j == 0) fprintf(stderr,"->\n"); 
              else 
              fprintf(stderr,"\n"); 
        }
     }
  }



void yyyCheckNodeInstancesSolved(np)
  yyyGNT *np;
  {int mysort,sortSize,i,prodNum,symPos,inTerminalNode;
   int nUnsolvedInsts = 0;

   if (np->prodNum != 0)
     {inTerminalNode = 0;
      prodNum = np->prodNum;
      symPos = 0;
     }
   else
     {inTerminalNode = 1;
      prodNum = ((yyyGNT *)(np->parent))->prodNum;
      symPos = np->whichSym;
     }
   mysort = yyySortOf(prodNum,symPos);
   sortSize = yyySizeofSort(mysort);
   for (i=0; i<sortSize; i++)
     if ((np->refCountList)[i] != 0) nUnsolvedInsts += 1;
   if (nUnsolvedInsts)
     {fprintf(stderr,
      "\nFound node that has %d unsolved attribute instance(s).\n",
              nUnsolvedInsts
             );
      fprintf(stderr,"Node is labeled \"%s\".\n",
             yyyGSoccurStr(prodNum,symPos));
      if (inTerminalNode)
        {fprintf(stderr,
                 "Node is terminal.  Its parent production is:\n  ");
         yyyShowProd(prodNum);
        }
      else
        {fprintf(stderr,"Node is nonterminal.  ");
         if (((char *)(np->parent)) >= yyyNodeSpace)
           {fprintf(stderr,
                    "Node is %dth child in its parent production:\n  ",
                   np->whichSym
                  );
            yyyShowProd(((yyyGNT *)(np->parent))->prodNum);
           }
         fprintf(stderr,
                 "Node is on left hand side of this production:\n  ");
         yyyShowProd(np->prodNum);
        }
      fprintf(stderr,"The following instances are unsolved:\n");
      for (i=0; i<sortSize; i++)
        if ((np->refCountList)[i] != 0)
          fprintf(stderr,"     %-16s still has %1d dependencies.\n",
                  yyyAttrbStr(prodNum,symPos,i),(np->refCountList)[i]);
     }
  }



void yyyUnsolvedInstSearchTravAux(pNode)
  yyyGNT *pNode;
  {yyyGNT **yyyCLpdum;
   int i;
  
   yyyCheckNodeInstancesSolved(pNode); 
   yyyCLpdum = pNode->cL;
   while
     ((yyyCLpdum != yyyNextCLspace) && ((*yyyCLpdum)->parent == pNode))
     {
      yyyUnsolvedInstSearchTravAux(*yyyCLpdum);
      yyyCLpdum++;
     }
  }



void yyyUnsolvedInstSearchTrav(pNode)
  yyyGNT *pNode;
  {yyyGNT **yyyCLpdum;
   int i;
  
   yyyCLpdum = pNode->cL;
   while
     ((yyyCLpdum != yyyNextCLspace) && ((*yyyCLpdum)->parent == pNode))
     {
      yyyUnsolvedInstSearchTravAux(*yyyCLpdum);
      yyyCLpdum++;
     }
  }



