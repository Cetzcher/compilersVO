%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char* );
    #include "scope.h"
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

@autosyn ids
@autosyn context
@autoinh inherited

@attributes { char* name;} id
@attributes { t_sym_table* ids; } ArgList Expr ExprList Term PrefixTerm
@attributes { t_sym_table* context; t_sym_table* inherited; } FuncdefList Funcdef StatList Stat VarDef

%%

Program: FuncdefList ';' @{ @i @FuncdefList.inherited@ = @FuncdefList.context@; @}
    ;

FuncdefList: Funcdef
    @{
        @i @FuncdefList.context@ = @Funcdef.context@;
        @i @Funcdef.inherited@ = empty_node();
    @}
    | FuncdefList ';' Funcdef
    @{
        @i @FuncdefList.0.context@ = append_end(@FuncdefList.1.context@, @Funcdef.context@);
        @i @Funcdef.inherited@ = @FuncdefList.1.context@;
        @i @FuncdefList.1.inherited@ = @FuncdefList.0.context@;
    @}
    ;

Funcdef: id '(' ArgList ')' StatList TEND 
    @{ 
        @i @Funcdef.context@ = lookup_sym(@Funcdef.inherited@, sym_node(@id.name@), @id.name@, FAIL_IF_FOUND); 
        @i @StatList.inherited@ = append_end(@Funcdef.context@, @ArgList.ids@);
    @}
    ;


ArgList:       /* empty */  @{ @i @ArgList.ids@ = empty_node(); @}
    | id                    @{ @i @ArgList.ids@ = sym_node(@id.name@); @}
    | ArgList ',' id        @{ @i @ArgList.ids@ = append_end(@ArgList.1.ids@, sym_node(@id.name@)); @}
    ;

StatList: Stat ';'       
    @{
        @i @StatList.context@ = @Stat.context@; /*TODO replace empty node with Stat.context*/ 
        @i @Stat.inherited@ = @StatList.inherited@;
    @}
    | StatList  Stat ';'
    @{
        @i @StatList.0.context@ = append_end(@StatList.1.context@, @Stat.context@);   /* // TODO replace empty node with Stat.context*/ 
        @i @Stat.inherited@ = @StatList.1.context@;
        @i @StatList.1.inherited@ = @StatList.0.inherited@;
    @}
    ;

Stat: 
    TRETURN Expr    @{ @i @Stat.context@ = NULL; @}
    | IfStat StatList TELSE StatList TEND
    @{
        @i @Stat.context@ = @Stat.inherited@;
        @i @StatList.inherited@ = @Stat.inherited@;
        @i @StatList.1.inherited@ = @Stat.inherited@;
    @}
    | IfStat StatList TEND
    @{
        @i @Stat.context@ = @Stat.inherited@;
        @i @StatList.inherited@ =  @Stat.inherited@;
    @}
    | LoopHead StatList TEND
    @{
        @i @Stat.context@ = @Stat.inherited@;
        @i @StatList.inherited@ =  @Stat.inherited@;
    @}
    | TBREAK id     @{ @i @Stat.context@ = lookup_sym(@Stat.inherited@, sym_node(@id.name@), @id.name@, FAIL_IF_FOUND); @}
    | TCONT id      @{ @i @Stat.context@ = NULL; @}  
    | VarDef        @{ @i @VarDef.inherited@ = @Stat.inherited@; @}    
    | VarAssignment @{ @i @Stat.context@ = NULL; @}
    | Expr          @{ @i @Stat.context@ = @Expr.ids@; @}
    ;

IfStat: TIF Expr TTHEN
    ;

LoopHead: id ':' TLOOP
    ;

VarDef: TVAR id assignment Expr 
    @{
        @i @VarDef.context@ = define(@VarDef.inherited@, sym_node(@id.name@), @Expr.ids@);
    @}
    ;

VarAssignment: id assignment Expr
    | '*' Term assignment Expr
    ;



    /* Either a term or a term and a prefix not having this causes shift/reduce conflicts */
PrefixTerm:	
        PrefixOp PrefixTerm
		| '*' PrefixTerm    /* we need to handle this case explicitly or else we will have s/r conflicts */
		| Term
		;

PrefixOp: '-'
    | TNOT
    ;

BinOp: '+' 
    | '*' 
    | '#'
    | lessThan
    | TAND
    ;

Expr: 
    PrefixTerm
    | Expr BinOp Term
    @{
        @i @Expr.ids@ = append_end(@Expr.1.ids@, @Term.ids@); 
    @}
    ;

    /* list of expressions is either expr or {expr, [expr]} in EBNF */
ExprList:   @{ @i @ExprList.ids@ = NULL; @} /* empty */ 
    | Expr
    | ExprList ',' Expr
    @{
        @i @ExprList.ids@ = append_end(@ExprList.1.ids@, @Expr.ids@);
    @}
    ;

Term: 
    '(' Expr ')'            @{ @i @Term.ids@ = @Expr.ids@; @}
    | number                @{ @i @Term.ids@ = empty_node(); @}
    | id                    @{ @i @Term.ids@ = sym_node(@id.name@); @}
    | id '(' ExprList ')'   @{ @i @Term.ids@ = sym_node(@id.name@); @}
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