#define TRUE 1
#define FALSE 0
#define FAIL_IF_FOUND  1
#define SUCCEED_IF_FOUND 2

typedef char* variable;
typedef int boolean; 

typedef struct t_sym_table
{
    struct t_sym_table* start;
    struct t_sym_table* next;
    variable var;
    boolean defined;

} t_sym_table;

t_sym_table* inital;

t_sym_table* rt_init();

t_sym_table* find_last(t_sym_table* sym);
t_sym_table* append_end(t_sym_table* s, t_sym_table* other);
t_sym_table* lookup_sym(t_sym_table* table, t_sym_table* rt, variable var, int mode);
t_sym_table* sym_node(variable var);
t_sym_table* empty_node();
t_sym_table* define_var(t_sym_table* table, t_sym_table* lhs, t_sym_table* rhs);
t_sym_table* check(t_sym_table* table, t_sym_table* other, int mode);
t_sym_table* assign(t_sym_table* table, t_sym_table* lhs, t_sym_table* rhs);
t_sym_table* copy(t_sym_table* other);
void debug_sym(t_sym_table* sym, char* hint);
//t_sym_table* is_defined(t_sym_table* table, t_sym_table* other);
//t_sym_table* is_undefined(t_sym_table* table, t_sym_table* other);
//t_sym_table* check_rhs(t_sym_table* table, t_sym_table* rhs);

















typedef struct SymbolTree {

    struct SymbolTree *parent;
    struct SymbolTree** children;
    variable var;
    int size;
    int count;
    int childIndex;

} SymbolTree;

SymbolTree* newTree(variable var);
SymbolTree* single(variable var);
SymbolTree* addChild(SymbolTree* tree, SymbolTree* child);
// adds all children of parent of child to tree at the curent level
SymbolTree* addChildren(SymbolTree* tree, SymbolTree* parent_of_childs);
SymbolTree* root(SymbolTree* sym) ;
void debugSymTree(SymbolTree* tree, int depth);

// looks for var in the tree above and to the left i.e occouring before the node of tree
// exit(4) if var is not found
void lookup_node(SymbolTree* tree, variable var);
// validates the current level to check if any variable is declared twice
// retruns the tree if successful or exit(3) otherwise 
void validate(SymbolTree* tree);



