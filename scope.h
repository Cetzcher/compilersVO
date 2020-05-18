#ifndef SCOPE_H
#define SCOPE_H

#include "registerinfo.h"

#define TRUE 1
#define FALSE 0
#define FAIL_IF_FOUND  1
#define SUCCEED_IF_FOUND 2

typedef char* variable;
typedef int boolean; 
enum MType {
    None = 0,
    Loop = 1,
    Statement = 2,
    If = 3,
    Assignment = 4,
    Loopref = 5,
    ExpressionStatement = 6,
    Return = 7,
    Funcdef = 8,
    Param = 9,
    OpNode = 10,
    Call = 11,
    Variable = 12
};

typedef enum MType MetaType; 
typedef struct burm_state *STATEPTR_TYPE; 



typedef struct SymbolTree {
    struct SymbolTree *link;                    // links a symbol to its first occourence in scope or parents scope
    struct SymbolTree *parent;
    struct SymbolTree** children;
    unsigned short size;        // size of children allocated
    unsigned short count;       // number of children currently used
    unsigned short childIndex;  // index in parents children
    int line;
    MetaType type;              // contains additional information about the type of node

    // additional information
    variable var;       // name of variable only if OP_Var is set 
    long value;         // value of the underlying number, op should be NUM
    int op;             // operator code see instuctions.h
    int memref;         // location of variable on stack,  op should be OP_VAR
    int declaredVars;   // how many variables are currently declared
    int parameters;     // parameter count   
    reginfo* assignedRegister;

    // burm state
    STATEPTR_TYPE stateLabel; 

} SymbolTree;

typedef SymbolTree* Sympointer;
#define NODEPTR_TYPE    	Sympointer
#define OP_LABEL(p)     	((p)->op)
#define LEFT_CHILD(p)   	((p)->children[0])
#define RIGHT_CHILD(p)  	((p)->children[1])
#define STATE_LABEL(p)  	((p)->stateLabel)
#define PANIC			    printf

SymbolTree* newTree(variable var);
SymbolTree* newTree2(variable var, int lineno);
SymbolTree* single2(variable var, int lineno);
SymbolTree* single(variable var);
SymbolTree* metaNode(MetaType type);
SymbolTree* loopNode(SymbolTree* curnode);
SymbolTree* loopRefNode(SymbolTree* var);
SymbolTree* returnNode();
SymbolTree* func(SymbolTree* name, SymbolTree* params, SymbolTree* body);
SymbolTree* param(SymbolTree* before, SymbolTree* cur);
SymbolTree* decl(SymbolTree* node);
SymbolTree* statements(SymbolTree* stmts, SymbolTree* stmt);
SymbolTree* num(long val);
SymbolTree* ID(SymbolTree* sym);
SymbolTree* addChild(SymbolTree* tree, SymbolTree* child);
SymbolTree* exprnode(SymbolTree* left, SymbolTree* op, SymbolTree* right);
SymbolTree* opnode(int op, SymbolTree* child);
SymbolTree* oplist(SymbolTree* lst, SymbolTree* head);
// adds all children of parent of child to tree at the curent level
SymbolTree* addChildren(SymbolTree* tree, SymbolTree* parent_of_childs);
SymbolTree* addChildrenMode(SymbolTree* tree, SymbolTree* parent_of_childs, boolean validate_tree);
SymbolTree* root(SymbolTree* sym) ;
void debugSymTree(SymbolTree* tree, int depth);

// looks for var in the tree above and to the left i.e occouring before the node of tree
// true if found false otherwise
boolean lookup_node(SymbolTree* tree, variable var);
// validates the current level to check if any variable is declared twice
// retruns the tree if successful or exit(3) otherwise 
SymbolTree* validate(SymbolTree* tree);

// checks an entire subtree.
SymbolTree* checkSubtreeDeclared(SymbolTree* tree, SymbolTree* subtree);

// chcks that var was delcared starting from tree and looking left and up
void checkDeclared(SymbolTree* tree, variable var);

// starts at node and chcks that it 1) has a loop ancestor and 2) that the loops variable is equal to var 
// this function uses node->var for comparison
void checkLooprefCorrect(SymbolTree* node);


void checkLoopUnique(SymbolTree* loop);
#endif