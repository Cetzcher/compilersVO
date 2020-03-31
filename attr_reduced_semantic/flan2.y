%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char* );
    #include "scope.h"

    void dbg(char* text) {
        printf("\t\t%s\n", text);
    }

    void* as(void* in, char* txt) {
        printf("%s\n", txt);
        return in;
    }
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
%token TPROC

%token id
%token number
%token lessThan     /* <= */
%token assignment   /* := */


@autosyn context
@autoinh inherited

@attributes { SymbolTree* sym;} id
@attributes {SymbolTree* ids;} ArgList
@attributes { SymbolTree* context; SymbolTree* inherited; } StmtList Stmt Funcdef FuncList
@traversal @preorder t

%%

Program: FuncList @{ @i @FuncList.inherited@ = @FuncList.context@; @}
    ;

FuncList:
    Funcdef
    @{ 
       @i @FuncList.context@ = addChild(newTree("!root"), @Funcdef.context@);
    @}
    | FuncList  Funcdef
    @{ 
        @i @FuncList.context@ = addChild(@FuncList.1.context@, @Funcdef.context@);
        
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

StmtList: Stmt
    @{
        @i @StmtList.context@ = addChild(newTree("!Meta"), @Stmt.context@);
    @}
    | StmtList Stmt
    @{ 
        @i @StmtList.context@ = addChild(@StmtList.1.context@, @Stmt.context@);
    @}
    ; 

Stmt: TVAR id assignment id      ';'    
    @{ 
        @i @Stmt.context@ = @id.sym@; 
        @t { printf("id:%s", @id.sym@->var); debugSymTree(root(@Stmt.inherited@), 0); lookup_node(@id.0.sym@, @id.1.sym@->var);}
    @}
    ;


%%

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
    exit(2);
}
int main() {
    yyparse();
    return 0;
}
