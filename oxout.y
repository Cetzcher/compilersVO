/* output from Ox version G1.04 */
%{
%}
%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char* );
    #include "scope.h"
    #include "instructions.h"
    #include "registerinfo.h"
    //yydebug = 1;
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

%token id
%token number
%token lessThan     /* <= */
%token assignment   /* := */







 
   
    
 ;
                
    





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
Program: 
    {if(yyyYok){
yyyRSU(1,0,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+0);}}| FuncList 
    {if(yyyYok){
yyyRSU(2,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+3);/*yyyPrune(2);*/}}
    ;

FuncList:
    Funcdef
    {if(yyyYok){
yyyRSU(3,1,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+3,yyyRCIL+9);}}
    | FuncList  Funcdef
    {if(yyyYok){
yyyRSU(4,2,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+9,yyyRCIL+18);}}
    ;

Funcdef: id '(' Args ')' StmtList TEND  ';'  
    {if(yyyYok){
yyyRSU(5,7,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+18,yyyRCIL+24);}}
    ;


Args:     /* empty */                  {if(yyyYok){
yyyRSU(6,0,1,5);
yyyGenIntNode();
 (((yyyP5)yyySTsn)->ids) = param(NULL, NULL); yyyAdjustINRC(yyyRCIL+24,yyyRCIL+27);}}
    | ArgsTrailed id                   {if(yyyYok){
yyyRSU(7,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+27,yyyRCIL+30);/*yyyPrune(7);*/}}
    | ArgsTrailed                       
    {if(yyyYok){
yyyRSU(8,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+30,yyyRCIL+33);/*yyyPrune(8);*/}}| id                               {if(yyyYok){
yyyRSU(9,1,1,5);
yyyGenIntNode();
 (((yyyP5)yyySTsn)->ids) = param(NULL, (((yyyP2)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym)); yyyAdjustINRC(yyyRCIL+33,yyyRCIL+36);/*yyyPrune(9);*/}}
    ;

ArgsTrailed: id ','                  {if(yyyYok){
yyyRSU(10,2,1,5);
yyyGenIntNode();
 (((yyyP5)yyySTsn)->ids) = param(NULL, (((yyyP2)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym)); yyyAdjustINRC(yyyRCIL+36,yyyRCIL+39);/*yyyPrune(10);*/}} 
    | ArgsTrailed id ','             {if(yyyYok){
yyyRSU(11,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+39,yyyRCIL+42);/*yyyPrune(11);*/}}
    ;

StmtList: /* empty */ 
    {if(yyyYok){
yyyRSU(12,0,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = metaNode(ExpressionStatement); 
        yyyAdjustINRC(yyyRCIL+42,yyyRCIL+45);}} 
    | Stmt 
    {if(yyyYok){
yyyRSU(13,1,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+45,yyyRCIL+51);/*yyyPrune(13);*/}}
    | StmtList Stmt 
    {if(yyyYok){
yyyRSU(14,2,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+51,yyyRCIL+60);/*yyyPrune(14);*/}}
    ; 

Stmt: TVAR id assignment Expression    ';'     
    {if(yyyYok){
yyyRSU(15,5,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = decl((((yyyP2)(((char *)((yyySTN->cL)[1]))+yyyGNSz))->sym)); 
        yyyAdjustINRC(yyyRCIL+60,yyyRCIL+63);/*yyyPrune(15);*/}}
    | id assignment Expression          ';'
    {if(yyyYok){
yyyRSU(16,4,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = addChild(metaNode(Assignment), (((yyyP2)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym)); 
        /*we add the id as a pseudo node this way it is actually in the tree and we can perform a lookup on traversal */ 
        yyyAdjustINRC(yyyRCIL+63,yyyRCIL+66);/*yyyPrune(16);*/}}
    | IfExprHead StmtList TEND ';'
    {if(yyyYok){
yyyRSU(17,4,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+66,yyyRCIL+72);}}
    | IfExprHead StmtList TELSE StmtList TEND ';'
    {if(yyyYok){
yyyRSU(18,6,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+72,yyyRCIL+81);}}
    | LoopHead StmtList TEND ';'
    {if(yyyYok){
yyyRSU(19,4,2,6);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+81,yyyRCIL+87);}}
    | TBREAK id ';'
    {if(yyyYok){
yyyRSU(20,3,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = loopRefNode((((yyyP2)(((char *)((yyySTN->cL)[1]))+yyyGNSz))->sym));
        /*we need to validate that id is actually a loop and that this statement is within the loop body*/
        yyyAdjustINRC(yyyRCIL+87,yyyRCIL+90);/*yyyPrune(20);*/}}
    | TCONT id ';'
    {if(yyyYok){
yyyRSU(21,3,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = loopRefNode((((yyyP2)(((char *)((yyySTN->cL)[1]))+yyyGNSz))->sym));
        yyyAdjustINRC(yyyRCIL+90,yyyRCIL+93);/*yyyPrune(21);*/}}
    | MemAcess assignment Expression ';'
    {if(yyyYok){
yyyRSU(22,4,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = metaNode(Assignment);
        yyyAdjustINRC(yyyRCIL+93,yyyRCIL+96);/*yyyPrune(22);*/}}
    | Expression   ';'                     
    {if(yyyYok){
yyyRSU(23,2,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = metaNode(ExpressionStatement); 
        yyyAdjustINRC(yyyRCIL+96,yyyRCIL+99);/*yyyPrune(23);*/}}
    | TRETURN Expression ';'
    {if(yyyYok){
yyyRSU(24,3,2,6);
yyyGenIntNode();
 (((yyyP6)yyySTsn)->context) = returnNode();
        yyyAdjustINRC(yyyRCIL+99,yyyRCIL+102);/*yyyPrune(24);*/}}
    ;

IfExprHead: TIF Expression TTHEN
    {if(yyyYok){
yyyRSU(25,3,2,4);
yyyGenIntNode();
 (((yyyP4)yyySTsn)->closelab) = createLable(); yyyAdjustINRC(yyyRCIL+102,yyyRCIL+108);/*yyyPrune(25);*/}}
    ;
LoopHead: id ':' TLOOP{if(yyyYok){
yyyRSU(26,3,1,2);
yyyGenIntNode();
(((yyyP2)yyySTsn)->sym) = (((yyyP2)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym);
yyyAdjustINRC(yyyRCIL+108,yyyRCIL+111);/*yyyPrune(26);*/}};

Unary: 
    TNOT    {if(yyyYok){
yyyRSU(27,1,1,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->op) = opnode(OP_NOT, NULL); yyyAdjustINRC(yyyRCIL+111,yyyRCIL+114);/*yyyPrune(27);*/}} 
    | '-'   {if(yyyYok){
yyyRSU(28,1,1,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->op) = opnode(OP_MINUS, NULL); yyyAdjustINRC(yyyRCIL+114,yyyRCIL+117);/*yyyPrune(28);*/}}
    | '*'   {if(yyyYok){
yyyRSU(29,1,1,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->op) = opnode(OP_MEMACESS, NULL); yyyAdjustINRC(yyyRCIL+117,yyyRCIL+120);/*yyyPrune(29);*/}}
    ;

UnaryList: Unary
    {if(yyyYok){
yyyRSU(30,1,1,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+120,yyyRCIL+123);/*yyyPrune(30);*/}}
    | UnaryList Unary   
    {if(yyyYok){
yyyRSU(31,2,1,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+123,yyyRCIL+126);/*yyyPrune(31);*/}}
    ;

PrefixTerm: UnaryList Term                              {if(yyyYok){
yyyRSU(32,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+126,yyyRCIL+129);/*yyyPrune(32);*/}} 
    ;

SumExpr: Term '+' Term {if(yyyYok){
yyyRSU(33,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+129,yyyRCIL+132);/*yyyPrune(33);*/}}
    | SumExpr '+' Term {if(yyyYok){
yyyRSU(34,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+132,yyyRCIL+135);/*yyyPrune(34);*/}}
    ;

ProductExpr: Term '*' Term {if(yyyYok){
yyyRSU(35,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+135,yyyRCIL+138);/*yyyPrune(35);*/}}
    | ProductExpr '*' Term {if(yyyYok){
yyyRSU(36,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+138,yyyRCIL+141);/*yyyPrune(36);*/}}
    ;

AndExpr: Term TAND Term  {if(yyyYok){
yyyRSU(37,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+141,yyyRCIL+144);/*yyyPrune(37);*/}} 
    | AndExpr TAND Term  {if(yyyYok){
yyyRSU(38,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+144,yyyRCIL+147);/*yyyPrune(38);*/}}
    ;

CompareExpr: Term lessThan Term {if(yyyYok){
yyyRSU(39,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+147,yyyRCIL+150);/*yyyPrune(39);*/}}
    | Term '#' Term             {if(yyyYok){
yyyRSU(40,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+150,yyyRCIL+153);/*yyyPrune(40);*/}}
    ;


Expression:                                     
    PrefixTerm
    {if(yyyYok){
yyyRSU(41,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+153,yyyRCIL+156);/*yyyPrune(41);*/}}| SumExpr
    {if(yyyYok){
yyyRSU(42,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+156,yyyRCIL+159);/*yyyPrune(42);*/}}| ProductExpr
    {if(yyyYok){
yyyRSU(43,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+159,yyyRCIL+162);/*yyyPrune(43);*/}}| AndExpr
    {if(yyyYok){
yyyRSU(44,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+162,yyyRCIL+165);/*yyyPrune(44);*/}}| CompareExpr
    {if(yyyYok){
yyyRSU(45,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+165,yyyRCIL+168);/*yyyPrune(45);*/}}| Term
    {if(yyyYok){
yyyRSU(46,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+168,yyyRCIL+171);/*yyyPrune(46);*/}};

CallArgs: /* empty */              {if(yyyYok){
yyyRSU(47,0,1,5);
yyyGenIntNode();
 (((yyyP5)yyySTsn)->ids) = metaNode(ExpressionStatement); yyyAdjustINRC(yyyRCIL+171,yyyRCIL+174);}}
    | CallArgsTrailed Expression    {if(yyyYok){
yyyRSU(48,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+174,yyyRCIL+177);/*yyyPrune(48);*/}}
    | CallArgsTrailed
    {if(yyyYok){
yyyRSU(49,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+177,yyyRCIL+180);/*yyyPrune(49);*/}}| Expression                    {if(yyyYok){
yyyRSU(50,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+180,yyyRCIL+183);/*yyyPrune(50);*/}}
    ;

CallArgsTrailed: Expression ','         {if(yyyYok){
yyyRSU(51,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+183,yyyRCIL+186);/*yyyPrune(51);*/}}
    | CallArgsTrailed Expression ','    {if(yyyYok){
yyyRSU(52,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+186,yyyRCIL+189);/*yyyPrune(52);*/}}
    ;


MemAcess: '*' Term 
    {if(yyyYok){
yyyRSU(53,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+189,yyyRCIL+192);/*yyyPrune(53);*/}};

Call: id '(' CallArgs ')'   {if(yyyYok){
yyyRSU(54,4,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+192,yyyRCIL+195);/*yyyPrune(54);*/}}
    ;


Term: 
    number                  {if(yyyYok){
yyyRSU(55,1,1,5);
yyyGenIntNode();
 (((yyyP5)yyySTsn)->ids) = num((((yyyP1)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->value)); yyyAdjustINRC(yyyRCIL+195,yyyRCIL+198);/*yyyPrune(55);*/}}
    | '(' Expression ')'  
    {if(yyyYok){
yyyRSU(56,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+198,yyyRCIL+201);/*yyyPrune(56);*/}}| id                    {if(yyyYok){
yyyRSU(57,1,1,5);
yyyGenIntNode();
 (((yyyP5)yyySTsn)->ids) = ID((((yyyP2)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->sym)); yyyAdjustINRC(yyyRCIL+201,yyyRCIL+204);/*yyyPrune(57);*/}}
    | Call
    {if(yyyYok){
yyyRSU(58,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+204,yyyRCIL+207);/*yyyPrune(58);*/}};
 


%%

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
    exit(2);
}
int main() {
    yyparse();
    //printf(" *** Parsed programm *** \n");
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
yyyR,0,2, 4,1,1, yyyR,0,0, yyyR,0,1, yyyR,0,1, yyyR,0,0, 
yyyR,0,0, yyyR,0,1, yyyR,0,0, yyyR,0,1, 0,1,1, yyyR,0,2, 
0,1,1, 1,1,1, yyyR,0,0, yyyR,0,0, yyyR,0,1, 1,1,1, 
yyyR,0,2, 1,1,1, 3,1,1, yyyR,0,2, 1,1,1, yyyR,0,0, 
yyyR,0,0, yyyR,0,0, yyyR,0,0, yyyR,0,0, yyyR,0,1, yyyR,1,0, 
yyyR,0,0, yyyR,0,0, yyyR,0,0, yyyR,0,0, yyyR,0,1, yyyR,0,2, 
yyyR,0,2, yyyR,0,2, yyyR,0,2, yyyR,0,2, yyyR,0,2, yyyR,0,2, 
yyyR,0,2, yyyR,0,2, yyyR,0,2, yyyR,0,1, yyyR,0,1, yyyR,0,1, 
yyyR,0,1, yyyR,0,1, yyyR,0,1, yyyR,0,0, yyyR,0,2, yyyR,0,1, 
yyyR,0,1, yyyR,0,1, yyyR,0,2, yyyR,0,1, yyyR,0,1, yyyR,0,0, 
yyyR,0,1, yyyR,0,0, yyyR,0,1, 
};

short yyyIIIEL[] = {0,
0,1,3,5,8,16,17,20,22,24,
27,31,32,34,37,43,48,53,60,65,
69,73,78,81,85,89,93,95,97,99,
101,104,107,111,115,119,123,127,131,135,
139,141,143,145,147,149,151,152,155,157,
159,162,166,169,174,176,180,182,
};

long yyyIIEL[] = {
0,0,0,2,4,6,8,10,12,14,15,15,
16,16,18,18,18,19,20,21,22,23,24,25,
26,27,28,28,29,30,31,31,33,35,37,39,
41,43,45,45,46,46,47,47,49,50,50,51,
51,53,55,57,57,57,59,61,63,63,65,65,
65,67,68,70,70,70,72,72,73,73,75,75,
76,76,78,79,79,80,80,82,83,83,85,85,
86,86,88,88,89,89,90,91,91,91,92,92,
93,93,94,94,95,96,97,98,99,100,101,102,
103,104,104,105,106,107,107,108,109,110,110,111,
112,113,113,114,115,116,116,117,118,119,119,120,
121,122,122,123,124,125,125,126,127,128,129,130,
131,132,133,134,135,136,137,138,139,140,141,142,
143,144,145,146,147,148,148,149,150,151,151,152,
152,153,154,155,155,156,156,157,158,159,159,160,
160,161,162,163,
};

long yyyIEL[] = {
0,2,2,2,4,6,6,6,
10,12,12,14,14,14,16,18,
20,22,22,22,22,24,26,26,
28,28,30,30,32,32,34,36,
36,36,38,38,40,40,44,44,
46,46,48,48,48,48,50,50,
50,50,52,52,52,54,54,54,
56,56,56,60,60,60,62,62,
64,64,64,66,68,70,70,70,
70,72,72,72,74,74,74,74,
74,74,74,74,74,74,74,74,
74,76,76,78,78,78,78,78,
80,80,82,84,84,86,88,88,
90,92,92,94,96,96,98,100,
100,102,104,104,106,108,108,110,
112,112,114,116,116,118,120,120,
122,122,124,124,126,126,128,128,
130,130,132,132,132,134,136,136,
138,138,140,140,142,142,144,146,
146,148,148,148,150,150,152,152,
154,154,156,156,158,
};

yyyFT yyyEntL[] = {
1,1,1,1,0,0,2,1,1,1,0,0,0,0,5,1,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,1,1,0,0,1,1,2,1,0,0,0,0,
0,0,0,0,2,1,0,0,4,1,2,1,0,0,0,0,
2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,
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
int yyyNdSz[7];

int yyyNdPrSz[7];

typedef int yyyCopyType;

int yyyNdCopySz[7];
long yyyBiggestNodeSize = 0;

void yyyNodeSizeCalc()
  {int i;
   yyyGNSz = yyyCeiling(yyyGNSz,yyyAlignSize); 
   yyyNdSz[0] = 0;
   yyyNdSz[1] = sizeof(struct yyyT1);
   yyyNdSz[2] = sizeof(struct yyyT2);
   yyyNdSz[3] = sizeof(struct yyyT3);
   yyyNdSz[4] = sizeof(struct yyyT4);
   yyyNdSz[5] = sizeof(struct yyyT5);
   yyyNdSz[6] = sizeof(struct yyyT6);
   for (i=0;i<7;i++) 
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
  }
break;
case 2:  /***yacc rule 2***/
  switch (yyyws) {
  case 1:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context); 
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
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChild(newTree("!root"), validate((((yyyP6)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context)));
        break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
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
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = validate(addChild((((yyyP6)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context), (((yyyP6)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->context)));
        
        break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 1:
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 5:  /***yacc rule 5***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = func((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->sym), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids), (((yyyP6)(((char *)((yyyRefN->cL)[4]))+yyyGNSz))->context)); 
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
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
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
  }
break;
case 7:  /***yacc rule 7***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = param((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP2)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->sym));     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
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
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 9:  /***yacc rule 9***/
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
case 10:  /***yacc rule 10***/
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
case 11:  /***yacc rule 11***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = param((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP2)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->sym));     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 12:  /***yacc rule 12***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 13:  /***yacc rule 13***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = statements((((yyyP6)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context), NULL);
            yyySignalEnts(yyyRefN,yyyEntL+36,yyyEntL+38);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->context); 
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
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = statements((((yyyP6)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->context), (((yyyP6)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->context));
            yyySignalEnts(yyyRefN,yyyEntL+40,yyyEntL+44);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->context);  
            break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->context);
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
  case 4:  /**/
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
case 17:  /***yacc rule 17***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = (((yyyP6)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->context);
            break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 1:
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 18:  /***yacc rule 18***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = ifThenElse((((yyyP6)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->context), (((yyyP6)(((char *)((yyyRefN->cL)[3]))+yyyGNSz))->context));
            break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 1:
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    case 1:
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 19:  /***yacc rule 19***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->context) = addChildren(loopNode((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->sym)), (((yyyP6)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->context));
            break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 1:
(((yyyP6)(((char *)yyyRSTopN)+yyyGNSz))->inherited) = (((yyyP6)(((char *)yyyRefN)+yyyGNSz))->inherited);
    break;
    }
  break;
  }
break;
case 20:  /***yacc rule 20***/
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
case 21:  /***yacc rule 21***/
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
case 22:  /***yacc rule 22***/
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
case 23:  /***yacc rule 23***/
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
case 24:  /***yacc rule 24***/
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
case 25:  /***yacc rule 25***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids);
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
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 27:  /***yacc rule 27***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 28:  /***yacc rule 28***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 29:  /***yacc rule 29***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 30:  /***yacc rule 30***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->op) = (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->op);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 31:  /***yacc rule 31***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->op) = oplist((((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->op), (((yyyP3)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->op));     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
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
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids), (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->op), NULL);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
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
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_PLUS, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_PLUS, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_MULT, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
case 36:  /***yacc rule 36***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_MULT, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
case 37:  /***yacc rule 37***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_AND, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_AND, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
case 39:  /***yacc rule 39***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_LTEQ, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
case 40:  /***yacc rule 40***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = exprnode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), opnode(OP_HASH, NULL), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids));     break;
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
case 41:  /***yacc rule 41***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 42:  /***yacc rule 42***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 43:  /***yacc rule 43***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 44:  /***yacc rule 44***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 45:  /***yacc rule 45***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 46:  /***yacc rule 46***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 47:  /***yacc rule 47***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 48:  /***yacc rule 48***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = addChildrenMode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP5)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids), FALSE);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 49:  /***yacc rule 49***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 50:  /***yacc rule 50***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 51:  /***yacc rule 51***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 52:  /***yacc rule 52***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = addChildrenMode((((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids), (((yyyP5)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids), FALSE);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 53:  /***yacc rule 53***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 54:  /***yacc rule 54***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = /*callNode(@id.sym@, @CallArgs.ids@)*/ addChildrenMode(newTree("!Call"), (((yyyP5)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->ids), FALSE);     break;
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
case 55:  /***yacc rule 55***/
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
case 56:  /***yacc rule 56***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 57:  /***yacc rule 57***/
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
case 58:  /***yacc rule 58***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->ids);
    break;
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


for (yyyi=0; yyyi<3; yyyi++) {
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
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 2:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { debugSymTree((((yyyP6)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->context), 0); 
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { init_codegen((((yyyP6)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->context));
    }
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
			}

break;
case 3:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 4:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 5:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { declare_func((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context));
    }
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
			}

break;
case 6:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 7:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 8:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 9:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 10:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 11:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 12:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { {instr_statements((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context)); }
    }
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
			}

break;
case 13:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { {instr_statements((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context)); }
    }
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
			}

break;
case 14:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { {instr_statements((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context)); }
    }
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
			}

break;
case 15:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym), (((yyyP5)(((char *)((yyyTSTn->cL)[3]))+yyyGNSz))->ids));
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { { assignMemref((((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym)); if(burm_label((((yyyP5)(((char *)((yyyTSTn->cL)[3]))+yyyGNSz))->ids))) { burm_reduce((((yyyP5)(((char *)((yyyTSTn->cL)[3]))+yyyGNSz))->ids), 1);  }}
    }
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
			}

break;
case 16:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { { checkDeclared((((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)->parent, (((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym));   checkSubtreeDeclared((((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)->parent, (((yyyP5)(((char *)((yyyTSTn->cL)[2]))+yyyGNSz))->ids)); } /* we look above the pseudo node, we also validate expression */
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { {instr_assignment((((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)); if(burm_label((((yyyP5)(((char *)((yyyTSTn->cL)[2]))+yyyGNSz))->ids))) { burm_reduce((((yyyP5)(((char *)((yyyTSTn->cL)[2]))+yyyGNSz))->ids), 1);}}
    }
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
			}

break;
case 17:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->ids));
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)
yyySetCond(1)

if (! (1)) yyySetCond(2)

				case 1:

if (yyyCond(0) != yyyPass) { instr_if((((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->ids), (((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->closelab));
        }
if (yyyCond(1) != yyyPass) { }
if (yyyCond(2) != yyyPass) { printf("%s:\n", (((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->closelab));
    }
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
			}

break;
case 18:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->ids));
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)
yyySetCond(1)

if (! (1)) yyySetCond(2)

				case 1:

if (yyyCond(0) != yyyPass) { instr_ifelse((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->ids), (((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->closelab));
        }
if (yyyCond(1) != yyyPass) { }
if (yyyCond(2) != yyyPass) { printf("%s:\n", (((yyyP4)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->closelab));
    }
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
			}

break;
case 19:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkLoopUnique((((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym));
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)
yyySetCond(1)

if (! (1)) yyySetCond(2)

				case 1:

if (yyyCond(0) != yyyPass) { printf("__%s:\n", (((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)->var);
        }
if (yyyCond(1) != yyyPass) { }
if (yyyCond(2) != yyyPass) { printf("__end%s:\n", (((yyyP2)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->sym)->var);
    }
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
			}

break;
case 20:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkLooprefCorrect((((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym)); 
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { { printf("\tjmp __end%s\n", (((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym)->var); }
    }
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
			}

break;
case 21:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkLooprefCorrect((((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym)); 
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { { printf("\tjmp __%s\n", (((yyyP2)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->sym)->var); }
    }
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
			}

break;
case 22:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { {checkSubtreeDeclared((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP5)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->ids)); checkSubtreeDeclared((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP5)(((char *)((yyyTSTn->cL)[2]))+yyyGNSz))->ids)); }
    }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 23:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP5)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->ids));
        /* all children of stmt must be declared before use */
    }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 24:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { checkSubtreeDeclared((((yyyP6)(((char *)yyyTSTn)+yyyGNSz))->context), (((yyyP5)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->ids));
        }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;yyySetCond(0)

				case 1:

if (yyyCond(0) != yyyPass) { { setTarget(getRAX()); if(burm_label((((yyyP5)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->ids))) { burm_reduce((((yyyP5)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->ids), 1); generate_return(); } else {printf("tree cannot be derived!\n"); } }
    }
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
			}

break;
case 25:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 26:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 27:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 28:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 29:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 30:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 31:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 32:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 33:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 34:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 35:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 36:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 37:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 38:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 39:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 40:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 41:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 42:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 43:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 44:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 45:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 46:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 47:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 48:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 49:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 50:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 51:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 52:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 53:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 54:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 55:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 56:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 57:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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
			}

break;
case 58:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

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



yyyWAT yyyLRCIL[2] = {0,0,
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
   
   
   


#define yyyLastProdNum 58


#define yyyNsorts 6


int yyyProdsInd[] = {
   0,
   0,   1,   3,   5,   8,  16,  17,  20,  22,  24,
  27,  31,  32,  34,  37,  43,  48,  53,  60,  65,
  69,  73,  78,  81,  85,  89,  93,  95,  97,  99,
 101, 104, 107, 111, 115, 119, 123, 127, 131, 135,
 139, 141, 143, 145, 147, 149, 151, 152, 155, 157,
 159, 162, 166, 169, 174, 176, 180, 182,
 184,
};


int yyyProds[][2] = {
{1013,   0},{1013,   0},{ 844,   6},{ 844,   6},{ 165,   6},
{ 844,   6},{ 844,   6},{ 165,   6},{ 165,   6},{ 907,   2},
{ 396,   0},{ 758,   5},{ 404,   0},{ 849,   6},{ 612,   0},
{ 548,   0},{ 758,   5},{ 758,   5},{  12,   5},{ 907,   2},
{ 758,   5},{  12,   5},{ 758,   5},{ 907,   2},{  12,   5},
{ 907,   2},{ 428,   0},{  12,   5},{  12,   5},{ 907,   2},
{ 428,   0},{ 849,   6},{ 849,   6},{ 235,   6},{ 849,   6},
{ 849,   6},{ 235,   6},{ 235,   6},{1143,   0},{ 907,   2},
{ 759,   0},{ 899,   5},{ 548,   0},{ 235,   6},{ 907,   2},
{ 759,   0},{ 899,   5},{ 548,   0},{ 235,   6},{ 337,   4},
{ 849,   6},{ 612,   0},{ 548,   0},{ 235,   6},{ 337,   4},
{ 849,   6},{ 775,   0},{ 849,   6},{ 612,   0},{ 548,   0},
{ 235,   6},{ 410,   2},{ 849,   6},{ 612,   0},{ 548,   0},
{ 235,   6},{ 537,   0},{ 907,   2},{ 548,   0},{ 235,   6},
{ 390,   0},{ 907,   2},{ 548,   0},{ 235,   6},{ 659,   5},
{ 759,   0},{ 899,   5},{ 548,   0},{ 235,   6},{ 899,   5},
{ 548,   0},{ 235,   6},{ 945,   0},{ 899,   5},{ 548,   0},
{ 337,   4},{ 227,   0},{ 899,   5},{ 458,   0},{ 410,   2},
{ 907,   2},{ 540,   0},{ 718,   0},{ 608,   3},{ 989,   0},
{ 608,   3},{ 436,   0},{ 608,   3},{ 412,   0},{ 804,   3},
{ 608,   3},{ 804,   3},{ 804,   3},{ 608,   3},{1103,   5},
{ 804,   3},{ 997,   5},{ 423,   5},{ 997,   5},{ 420,   0},
{ 997,   5},{ 423,   5},{ 423,   5},{ 420,   0},{ 997,   5},
{ 400,   5},{ 997,   5},{ 412,   0},{ 997,   5},{ 400,   5},
{ 400,   5},{ 412,   0},{ 997,   5},{ 349,   5},{ 997,   5},
{ 580,   0},{ 997,   5},{ 349,   5},{ 349,   5},{ 580,   0},
{ 997,   5},{ 363,   5},{ 997,   5},{1002,   0},{ 997,   5},
{ 363,   5},{ 997,   5},{ 356,   0},{ 997,   5},{ 899,   5},
{1103,   5},{ 899,   5},{ 423,   5},{ 899,   5},{ 400,   5},
{ 899,   5},{ 349,   5},{ 899,   5},{ 363,   5},{ 899,   5},
{ 997,   5},{ 628,   5},{ 628,   5},{1113,   5},{ 899,   5},
{ 628,   5},{1113,   5},{ 628,   5},{ 899,   5},{1113,   5},
{ 899,   5},{ 428,   0},{1113,   5},{1113,   5},{ 899,   5},
{ 428,   0},{ 659,   5},{ 412,   0},{ 997,   5},{ 274,   5},
{ 907,   2},{ 396,   0},{ 628,   5},{ 404,   0},{ 997,   5},
{ 972,   1},{ 997,   5},{ 396,   0},{ 899,   5},{ 404,   0},
{ 997,   5},{ 907,   2},{ 997,   5},{ 274,   5},
};


int yyySortsInd[] = {
  0,
  0,  1,  2,  3,  5,  6,
  8,
};


int yyySorts[] = {
  793,  676, 1009,  882,  281,  882,  922,   18,
};



char *yyyStringTab[] = {
0,"createLable",0,0,0,
0,0,0,"debugSymTree",0,
0,0,"ArgsTrailed","newTree",0,
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
"convertHex",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"statements",0,0,0,0,
0,0,0,0,0,
0,"n",0,0,0,
0,"s","t",0,0,
"tree","AND","y",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"SymbolTree",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"Funcdef",0,0,0,0,
"CallStart",0,0,0,0,
0,0,0,0,0,
0,"assignMemref",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"NULL","reduce",0,
0,0,"TIF",0,0,
0,0,0,0,0,
"Stmt",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"MINUS",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"Call",
0,0,0,0,0,
0,"closelab",0,0,"validate",
"PLUS",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"generate",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"TermOrCall",
0,0,0,0,0,
0,0,"IfExprHead",0,0,
0,0,0,0,0,
0,0,0,0,"AndExpr",
0,0,0,0,0,
0,"'#'",0,0,0,
0,0,0,"CompareExpr",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"TCONT",0,0,0,0,
0,"'('",0,0,0,
"ProductExpr",0,0,0,"')'",
0,0,0,0,0,
"LoopHead",0,"'*'",0,0,
0,"strdup",0,0,0,
"'+'",0,0,"SumExpr",0,
"label",0,0,"','",0,
0,0,0,0,0,
0,"'-'","getRAX","MEMACESS",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"TTHEN",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"printf",0,0,"single2",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"declare",
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
0,0,0,0,"atoi",
0,0,"addChildren",0,0,
0,0,0,0,0,
"TAND",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"Unary",0,
0,0,"TEND",0,0,
0,0,0,0,"ID",
0,0,0,"init",0,
0,"parent",0,"CallArgs",0,
0,0,0,0,0,
0,0,0,0,"num",
0,"LTEQ",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"decl",0,0,"codegen","MemAcess",
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
0,"OP",0,0,0,
0,0,"Assignment",0,"FALSE",
0,0,"metaNode","MULT",0,
0,0,0,0,"returnNode",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"Args","assignment",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"TELSE",0,0,0,0,
"ExpressionStatement",0,0,0,0,
0,0,0,0,0,
0,0,0,"value",0,
0,0,0,0,0,
0,0,0,0,"UnaryList",
0,0,"var",0,0,
0,"loopNode",0,0,"ArgList",
"loopRefNode",0,0,0,0,
"opnode",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"checkLoopUnique",0,0,"oplist","FuncList",
0,0,0,0,"StmtList",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"exprnode",0,0,0,
0,0,"ids",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"Expression",
0,0,0,0,0,
0,0,"id","param","be",
0,0,0,0,0,
0,0,"func",0,0,
0,0,"context","if","HASH",
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
"setTarget",0,0,0,0,
0,0,0,0,"TNOT",
0,0,0,0,0,
0,0,"Term",0,0,
0,0,"lessThan",0,0,
0,0,0,0,"op",
0,0,0,"Program",0,
0,0,0,0,0,
0,0,0,"yytext",0,
0,0,0,"ifelse",0,
0,0,"ifThenElse",0,0,
0,"BinaryOperator",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"addChild",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"else",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"return",0,
0,0,0,0,0,
"codegenClose",0,0,"PrefixTerm",0,
0,0,0,0,0,
0,0,0,"CallArgsTrailed",0,
0,0,0,0,0,
0,0,0,0,0,
"cannot",0,0,0,0,
0,0,0,0,0,
0,0,0,0,"burm",
0,0,0,"TVAR",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"tjmp",0,
"NOT",0,0,0,0,
"derived",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"checkDeclared",
0,0,0,0,"instr",
"checkLooprefCorrect","checkSubtreeDeclared",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"end",
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



