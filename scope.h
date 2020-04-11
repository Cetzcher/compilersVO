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
    Funcdef = 8
};

typedef enum MType MetaType; 

typedef struct SymbolTree {

    struct SymbolTree *parent;
    struct SymbolTree** children;
    unsigned short size;
    unsigned short count;
    unsigned short childIndex;
    variable var;
    int line;
    MetaType type;

} SymbolTree;



SymbolTree* newTree(variable var);
SymbolTree* newTree2(variable var, int lineno);
SymbolTree* single2(variable var, int lineno);
SymbolTree* single(variable var);
SymbolTree* metaNode(MetaType type);
SymbolTree* loopNode(SymbolTree* curnode);
SymbolTree* loopRefNode(SymbolTree* var);
SymbolTree* returnNode();
SymbolTree* function(SymbolTree* var);
SymbolTree* addChild(SymbolTree* tree, SymbolTree* child);
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