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


@autosyn context
@autoinh inherited
@autosyn ids

@attributes { SymbolTree* sym;} id
@attributes {SymbolTree* ids;} ArgList Expression Term Factor Call CallArgs
@attributes { SymbolTree* context; SymbolTree* inherited; } StmtList Stmt Funcdef FuncList
@traversal @preorder t

%%

Program: FuncList @{ @i @FuncList.inherited@ = @FuncList.context@; @t debugSymTree(@FuncList.context@, 0); @}
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

Funcdef: id '(' ArgList ')' StmtList TEND  ';'
    @{ 
        @i @Funcdef.context@ = addChildren(addChildren(@id.sym@, @ArgList.ids@), @StmtList.context@);
    @}
    ;

ArgList:       /* empty */  @{ @i @ArgList.ids@ = single("!Meta"); @}
    | id                    @{ @i @ArgList.ids@ = addChild(newTree("!Meta"), @id.sym@); @}
    | ArgList ',' id        @{ @i @ArgList.ids@ = addChild(@ArgList.1.ids@, @id.sym@); @}
    ;

StmtList: Stmt ';'
    @{
        @i @StmtList.context@ = addChild(metaNode(Statement), @Stmt.context@);
        @i @Stmt.inherited@ = @StmtList.context@; 
    @}
    | StmtList Stmt ';'
    @{ 
        @i @StmtList.context@ = addChild(@StmtList.1.context@, @Stmt.context@);
        @i @Stmt.inherited@ = @StmtList.context@;
        @i @StmtList.1.inherited@ = @StmtList.context@;  
    @}
    ; 

Stmt: TVAR id assignment Expression         
    @{ 
        @i @Stmt.context@ = @id.sym@; 
        @t checkSubtreeDeclared(@id.sym@, @Expression.ids@);
    @}
    | id assignment Expression          
    @{ 
        @i @Stmt.context@ = addChild(metaNode(Assignment), @id.sym@); 
        /*we add the id as a pseudo node this way it is actually in the tree and we can perform a lookup on traversal */ 
        @t { checkDeclared(@id.sym@->parent, @id.sym@->var);   checkSubtreeDeclared(@id.sym@->parent, @Expression.ids@); } /* we look above the pseudo node, we also validate expression */
    @}
    | TIF Expression TTHEN StmtList TEND
    @{
        @i @Stmt.context@ = @StmtList.context@;
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@);
    @}
    | TIF Expression TTHEN StmtList TELSE StmtList TEND
    @{
        @i @Stmt.context@ = addChild(addChild(metaNode(If), @StmtList.context@), @StmtList.1.context@);
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@);
    @}
    | id ':' TLOOP StmtList TEND
    @{
        @i @Stmt.context@ = addChildren(loopNode(@id.sym@), @StmtList.context@);
    @}
    | TBREAK id
    @{
        @i @Stmt.context@ = loopRefNode(@id.sym@);
        /*we need to validate that id is actually a loop and that this statement is within the loop body*/
        @t checkLooprefCorrect(@id.sym@); 
    @}
    | TCONT id
    @{
        @i @Stmt.context@ = loopRefNode(@id.sym@);
        @t checkLooprefCorrect(@id.sym@); 
    @}
    | '*' Term assignment Expression
    @{
        @i @Stmt.context@ = metaNode(Assignment);
        @t {checkSubtreeDeclared(@Stmt.context@, @Term.ids@); checkSubtreeDeclared(@Stmt.context@, @Expression.ids@); }
    @}
    | Expression                        
    @{ 
        @i @Stmt.context@ = metaNode(ExpressionStatement), @Expression.ids@; 
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@);
        /* all children of stmt must be declared before use */
    @}
    | TRETURN Expression
    @{
        @i @Stmt.context@ = returnNode();
        @t checkSubtreeDeclared(@Stmt.context@, @Expression.ids@);
    @}
    ;


BinaryOperator: '+' | '-' | lessThan | '#' | TAND
    ;

Expression:                                     
      Prefix Term
    | Expression BinaryOperator Term           @{ @i @Expression.ids@ = addChildrenMode(@Expression.1.ids@, @Term.ids@, FALSE); @}
    ;

Prefix:  
    | TNOT 
    | '*' 
    | '-'
    ;

CallArgs:                       @{ @i @CallArgs.ids@ = single("!CallArgs"); @}
    | Expression                @{ @i @CallArgs.ids@ = @Expression.ids@; @}
    | CallArgs ',' Expression   @{ @i @CallArgs.ids@ = addChildrenMode(@CallArgs.1.ids@, @Expression.ids@, FALSE); @}
    ;

Call: id '(' CallArgs ')'   @{ @i @Call.ids@ = addChildrenMode(addChild(newTree("!Call"), @id.sym@), @CallArgs.ids@, FALSE); @}
    ;

Term: 
    Factor
    | Call
    | Term '*' Factor   
    @{ 
        @i @Term.ids@ = addChildrenMode(@Term.1.ids@, @Factor.ids@, FALSE); 
    @}
    ;
 
Factor: 
    number                  @{ @i @Factor.ids@ = single("!number node"); @}
    | '(' Expression ')'    
    | id                    @{ @i @Factor.ids@ = addChild(newTree("!Factors"), @id.sym@); @}
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
