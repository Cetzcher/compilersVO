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


@autosyn context
@autoinh inherited
@autosyn ids
@autosyn sym

@attributes {long value; } number
@attributes { SymbolTree* sym;} id LoopHead CallStart
@attributes {SymbolTree* op;} BinaryOperator Unary UnaryList 
@attributes {SymbolTree* ids; char* closelab; } IfExprHead;
@attributes {SymbolTree* ids;} ArgList Expression Term Factor Call CallArgs MemAcess PrefixTerm TermOrCall Args ArgsTrailed CallArgsTrailed CompareExpr ProductExpr SumExpr AndExpr
@attributes { SymbolTree* context; SymbolTree* inherited; } StmtList Stmt Funcdef FuncList
@traversal @preorder t
@traversal @preorder codegen
@traversal @preorder codegenClose

%%
Program: 
    | FuncList 
    @{ 
        @i @FuncList.inherited@ = @FuncList.context@; 
        @t debugSymTree(@FuncList.context@, 0); 
        @codegen init_codegen(@FuncList.context@);
    @}
    ;

FuncList:
    Funcdef
    @{ 
       @i @FuncList.context@ = addChild(newTree("!root"), validate(@Funcdef.context@));
    @}
    | FuncList  Funcdef
    @{ 
        @i @FuncList.context@ = validate(addChild(@FuncList.1.context@, @Funcdef.context@));
        
    @}
    ;

Funcdef: id '(' Args ')' StmtList TEND  ';'  
    @{ 
        @i @Funcdef.context@ = func(@id.sym@, @Args.ids@, @StmtList.context@); 
        @codegen declare_func(@Funcdef.context@);
    @}
    ;


Args:     /* empty */                  @{ @i @Args.ids@ = param(NULL, NULL); @}
    | ArgsTrailed id                   @{ @i @Args.ids@ = param(@ArgsTrailed.ids@, @id.sym@); @}
    | ArgsTrailed                       
    | id                               @{ @i @Args.ids@ = param(NULL, @id.sym@); @}
    ;

ArgsTrailed: id ','                  @{ @i @ArgsTrailed.ids@ = param(NULL, @id.sym@); @} 
    | ArgsTrailed id ','             @{ @i @ArgsTrailed.ids@ = param(@ArgsTrailed.1.ids@, @id.sym@); @}
    ;

StmtList: /* empty */ 
    @{ 
        @i @StmtList.context@ = metaNode(ExpressionStatement); 
        @codegen {instr_statements(@StmtList.context@); }
    @} 
    | Stmt 
    @{
        @i @StmtList.context@ = statements(@Stmt.context@, NULL);
        @i @Stmt.inherited@ = @StmtList.context@; 
        @codegen {instr_statements(@StmtList.context@); }
    @}
    | StmtList Stmt 
    @{ 
        @i @StmtList.context@ = statements(@StmtList.1.context@, @Stmt.context@);
        @i @Stmt.inherited@ = @StmtList.context@;
        @i @StmtList.1.inherited@ = @StmtList.context@;  
        @codegen {instr_statements(@StmtList.context@); }
    @}
    ; 

Stmt: TVAR id assignment Expression    ';'     
    @{ 
        @i @Stmt.context@ = decl(@id.sym@); 
        @t checkSubtreeDeclared(@id.sym@, @Expression.ids@);
        @codegen { assignMemref(@id.sym@); if(burm_label(@Expression.ids@)) { burm_reduce(@Expression.ids@, 1);  } else { printf("tree cannot be derived\n"); }}
    @}
    | id assignment Expression          ';'
    @{ 
        @i @Stmt.context@ = addChild(metaNode(Assignment), @id.sym@); 
        /*we add the id as a pseudo node this way it is actually in the tree and we can perform a lookup on traversal */ 
        @t { checkDeclared(@id.sym@->parent, @id.sym@);   checkSubtreeDeclared(@id.sym@->parent, @Expression.ids@); } /* we look above the pseudo node, we also validate expression */
        @codegen {instr_assignment(@id.sym@); if(burm_label(@Expression.ids@)) { burm_reduce(@Expression.ids@, 1);}}
    @}
    | IfExprHead StmtList TEND ';'
    @{
        @i @Stmt.context@ = @StmtList.context@;
        @t checkSubtreeDeclared(@Stmt.context@, @IfExprHead.ids@);
        @codegen instr_if(@IfExprHead.ids@, @IfExprHead.closelab@) ;
        @codegen @revorder(1) printf("%s:\n", @IfExprHead.closelab@);
    @}
    | IfExprHead StmtList TELSE StmtList TEND ';'
    @{
        @i @Stmt.context@ = ifThenElse(@StmtList.context@, @StmtList.1.context@);
        @t checkSubtreeDeclared(@Stmt.context@, @IfExprHead.ids@);
        @codegen instr_ifelse(@Stmt.context@, @IfExprHead.ids@, @IfExprHead.closelab@);
        @codegen @revorder(1) printf("%s:\n", @IfExprHead.closelab@);
    @}
    | LoopHead StmtList TEND ';'
    @{
        @i @Stmt.context@ = loopNode(@LoopHead.sym@, @StmtList.context@);
        @t checkLoopUnique(@LoopHead.sym@);
        @codegen printf("__%s:\n", @LoopHead.sym@->var);
        @codegen @revorder(1) printf("\tjmp __%s # loops \n __end%s:\n", @LoopHead.sym@->var, @LoopHead.sym@->var);
    @}
    | TBREAK id ';'
    @{
        @i @Stmt.context@ = loopRefNode(@id.sym@);
        /*we need to validate that id is actually a loop and that this statement is within the loop body*/
        @t checkLooprefCorrect(@id.sym@); 
        @codegen { printf("\tjmp __end%s\n", @id.sym@->var); }
    @}
    | TCONT id ';'
    @{
        @i @Stmt.context@ = loopRefNode(@id.sym@);
        @t checkLooprefCorrect(@id.sym@); 
        @codegen { printf("\tjmp __%s\n", @id.sym@->var); }
    @}
    | '*' Term assignment Expression ';'
    @{
        @i @Stmt.context@ = metaNode(Assignment);
        @t {checkSubtreeDeclared(@Stmt.context@, @Term.ids@); checkSubtreeDeclared(@Stmt.context@, @Expression.ids@); }
        @codegen { instr_memacess(@Term.ids@, @Expression.ids@);}
    @}
    | Expression   ';'                     
    @{ 
        @i @Stmt.context@ = metaNode(ExpressionStatement); 
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@);
        /* all children of stmt must be declared before use */
        @codegen { printf("debugging expr stmt: \n"); debugSymTree(@Expression.ids@, 1); }
    @}
    | TRETURN Expression ';'
    @{
        @i @Stmt.context@ = returnNode();
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@); 
        @codegen { setTarget(getRAX()); if(burm_label(@Expression.ids@)) { burm_reduce(@Expression.ids@, 1); generate_return(); } else {printf("tree cannot be derived!\n"); } }
    @}
    ;

IfExprHead: TIF Expression TTHEN
    @{ @i @IfExprHead.closelab@ = createLable(); @}
    ;
LoopHead: id ':' TLOOP;

Unary: 
    TNOT    @{ @i @Unary.op@ = opnode(OP_NOT, NULL); @} 
    | '-'   @{ @i @Unary.op@ = opnode(OP_MINUS, NULL); @}
    | '*'   @{ @i @Unary.op@ = opnode(OP_MEMACESS, NULL); @}
    ;

UnaryList: Unary
    @{ @i @UnaryList.op@ = @Unary.op@; @}
    | UnaryList Unary   
    @{ @i @UnaryList.op@ = oplist(@UnaryList.1.op@, @Unary.op@); @}
    ;

PrefixTerm: UnaryList Term                              @{ @i @PrefixTerm.ids@ = exprnode(@Term.ids@, @UnaryList.op@, NULL); @} 
    ;

SumExpr: Term '+' Term @{ @i @SumExpr.ids@ = exprnode(@Term.0.ids@, opnode(OP_PLUS, NULL), @Term.1.ids@); @}
    | SumExpr '+' Term @{ @i @SumExpr.ids@ = exprnode(@SumExpr.1.ids@, opnode(OP_PLUS, NULL), @Term.ids@); @}
    ;

ProductExpr: Term '*' Term @{ @i @ProductExpr.ids@ = exprnode(@Term.0.ids@, opnode(OP_MULT, NULL), @Term.1.ids@); @}
    | ProductExpr '*' Term @{ @i @ProductExpr.ids@ = exprnode(@ProductExpr.1.ids@, opnode(OP_MULT, NULL), @Term.ids@); @}
    ;

AndExpr: Term TAND Term  @{ @i @AndExpr.ids@ = exprnode(@Term.0.ids@, opnode(OP_AND, NULL), @Term.1.ids@); @} 
    | AndExpr TAND Term  @{ @i @AndExpr.ids@ = exprnode(@AndExpr.1.ids@, opnode(OP_AND, NULL), @Term.ids@); @}
    ;

CompareExpr: Term lessThan Term @{ @i @CompareExpr.ids@ = exprnode(@Term.0.ids@, opnode(OP_LTEQ, NULL), @Term.1.ids@); @}
    | Term '#' Term             @{ @i @CompareExpr.ids@ = exprnode(@Term.0.ids@, opnode(OP_HASH, NULL), @Term.1.ids@); @}
    ;


Expression:                                     
    PrefixTerm
    | SumExpr
    | ProductExpr
    | AndExpr
    | CompareExpr
    | Term
    ;

CallArgs: /* empty */              @{ @i @CallArgs.ids@ = exprparam(NULL, NULL);/*metaNode(ExpressionStatement);*/ @}
    | CallArgsTrailed Expression    @{ @i @CallArgs.ids@ =  exprparam(@CallArgsTrailed.ids@, @Expression.ids@); /*addChildrenMode(@CallArgsTrailed.ids@, @Expression.ids@, FALSE);*/ @}
    | CallArgsTrailed
    | Expression                    @{ @i @CallArgs.ids@ = exprparam(NULL, @Expression.ids@);/*@Expression.ids@;*/ @}
    ;

CallArgsTrailed: Expression ','         @{ @i @CallArgsTrailed.ids@ = exprparam(NULL, @Expression.ids@);/*@Expression.ids@;*/ @}
    | CallArgsTrailed Expression ','    @{ @i @CallArgsTrailed.ids@ = exprparam(@CallArgsTrailed.1.ids@, @Expression.ids@); /*addChildrenMode(@CallArgsTrailed.1.ids@, @Expression.ids@, FALSE); */@}
    ;


Call: id '(' CallArgs ')'   
    @{ 
        @i @Call.ids@ = /*callNode(@id.sym@, @CallArgs.ids@)*/ callNode(addChildrenMode(newTree("!Call"), addChild(newTree("!meta"), addChildrenMode(@id.sym@, @CallArgs.ids@, FALSE)), FALSE)); 
    @}
    ;


Term: 
    number                  @{ @i @Term.ids@ = num(@number.value@); @}
    | '(' Expression ')'  
    | id                    @{ @i @Term.ids@ = ID(@id.sym@); @}
    | Call
    ;
 

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
