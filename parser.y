%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char* );
    #include "scope.h"
    #include "instructions.h"
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
@attributes {SymbolTree* ids;} ArgList Expression Term Factor Call CallArgs IfExprHead MemAcess PrefixTerm TermOrCall Args ArgsTrailed CallArgsTrailed 
@attributes { SymbolTree* context; SymbolTree* inherited; } StmtList Stmt Funcdef FuncList
@traversal @preorder t
@traversal @preorder codegen

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

StmtList: /* empty */ @{ @i @StmtList.context@ = metaNode(ExpressionStatement); @} 
    | Stmt 
    @{
        @i @StmtList.context@ = statements(@Stmt.context@, NULL);
        @i @Stmt.inherited@ = @StmtList.context@; 
    @}
    | StmtList Stmt 
    @{ 
        @i @StmtList.context@ = statements(@StmtList.1.context@, @Stmt.context@);
        @i @Stmt.inherited@ = @StmtList.context@;
        @i @StmtList.1.inherited@ = @StmtList.context@;  
    @}
    ; 

Stmt: TVAR id assignment Expression    ';'     
    @{ 
        @i @Stmt.context@ = decl(@id.sym@); 
        @t checkSubtreeDeclared(@id.sym@, @Expression.ids@);
    @}
    | id assignment Expression          ';'
    @{ 
        @i @Stmt.context@ = addChild(metaNode(Assignment), @id.sym@); 
        /*we add the id as a pseudo node this way it is actually in the tree and we can perform a lookup on traversal */ 
        @t { checkDeclared(@id.sym@->parent, @id.sym@->var);   checkSubtreeDeclared(@id.sym@->parent, @Expression.ids@); } /* we look above the pseudo node, we also validate expression */
    @}
    | IfExprHead StmtList TEND ';'
    @{
        @i @Stmt.context@ = @StmtList.context@;
        @t checkSubtreeDeclared(@Stmt.context@, @IfExprHead.ids@);
    @}
    | IfExprHead StmtList TELSE StmtList TEND ';'
    @{
        @i @Stmt.context@ = addChild(addChild(metaNode(If), @StmtList.context@), @StmtList.1.context@);
        @t checkSubtreeDeclared(@Stmt.context@, @IfExprHead.ids@);
    @}
    | LoopHead StmtList TEND ';'
    @{
        @i @Stmt.context@ = addChildren(loopNode(@LoopHead.sym@), @StmtList.context@);
        @t checkLoopUnique(@LoopHead.sym@);
    @}
    | TBREAK id ';'
    @{
        @i @Stmt.context@ = loopRefNode(@id.sym@);
        /*we need to validate that id is actually a loop and that this statement is within the loop body*/
        @t checkLooprefCorrect(@id.sym@); 
    @}
    | TCONT id ';'
    @{
        @i @Stmt.context@ = loopRefNode(@id.sym@);
        @t checkLooprefCorrect(@id.sym@); 
    @}
    | MemAcess assignment Expression ';'
    @{
        @i @Stmt.context@ = metaNode(Assignment);
        @t {checkSubtreeDeclared(@Stmt.context@, @MemAcess.ids@); checkSubtreeDeclared(@Stmt.context@, @Expression.ids@); }
    @}
    | Expression   ';'                     
    @{ 
        @i @Stmt.context@ = metaNode(ExpressionStatement); 
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@);
        /* all children of stmt must be declared before use */
    @}
    | TRETURN Expression ';'
    @{
        @i @Stmt.context@ = returnNode();
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@);
        @codegen { debugSymTree(@Expression.ids@, 0); if(burm_label(@Expression.ids@)) { burm_reduce(@Expression.ids@, 1); generate_return(); } }
    @}
    ;

IfExprHead: TIF Expression TTHEN;
LoopHead: id ':' TLOOP;
BinaryOperator: 
    '+'             @{ @i @BinaryOperator.op@ = opnode(OP_PLUS, NULL); @}
    | lessThan      @{ @i @BinaryOperator.op@ = opnode(OP_LTEQ, NULL); @}
    | '#'           @{ @i @BinaryOperator.op@ = opnode(OP_HASH, NULL); @}
    | TAND          @{ @i @BinaryOperator.op@ = opnode(OP_AND, NULL); @}
    | '*'           @{ @i @BinaryOperator.op@ = opnode(OP_MULT, NULL); @}
    ;

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

PrefixTerm: 
    UnaryList Term                              @{ @i @PrefixTerm.ids@ = exprnode(@Term.ids@, @UnaryList.op@, NULL); @} 
    | Term
    ;

Expression:                                     
    PrefixTerm
    | Expression BinaryOperator Term           @{ @i @Expression.ids@ = exprnode(@Expression.1.ids@, @BinaryOperator.op@, @Term.ids@); @}
    ;

CallArgs: /* empty */              @{ @i @CallArgs.ids@ = metaNode(ExpressionStatement); @}
    | CallArgsTrailed Expression    @{ @i @CallArgs.ids@ = addChildrenMode(@CallArgsTrailed.ids@, @Expression.ids@, FALSE); @}
    | CallArgsTrailed
    | Expression                    @{ @i @CallArgs.ids@ = @Expression.ids@; @}
    ;

CallArgsTrailed: Expression ','         @{ @i @CallArgsTrailed.ids@ = @Expression.ids@; @}
    | CallArgsTrailed Expression ','    @{ @i @CallArgsTrailed.ids@ = addChildrenMode(@CallArgsTrailed.1.ids@, @Expression.ids@, FALSE); @}
    ;


MemAcess: '*' Term 
    ;

Call: id '(' CallArgs ')'   @{ @i @Call.ids@ = /*callNode(@id.sym@, @CallArgs.ids@)*/ addChildrenMode(newTree("!Call"), @CallArgs.ids@, FALSE); @}
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
