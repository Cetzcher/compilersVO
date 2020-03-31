#include "scope.h"
#include <stdio.h>
#include <stdlib.h>

// looks for var in table and returns rt;
t_sym_table *lookup_sym(t_sym_table *table, t_sym_table *rt, variable var, int mode)
{
    printf("lookup called\n");
    if (table == NULL)
    {
        printf("\tno lookup context! \n");
        exit(4);
    }

    //debug_sym(table, "lookup context");
    t_sym_table *start = table->start;
    while (start != NULL)
    {
        if (start->defined)
        {
            if (strcmp(start->var, var) == 0)
            {
                if (mode == FAIL_IF_FOUND)
                {
                    printf("variable %s is already defined!\n", var);
                    exit(3);
                }
                return rt;
            }
        }
        start = start->next;
    }
    if (mode == FAIL_IF_FOUND)
    {
        // we have not found var in the context
        // and the mode is FAIL_IF_FOUND, so behaviour matches expected
        return rt;
    }

    printf("\tlookup failed for % s \n", var);
    exit(3);
}

t_sym_table *sym_node(variable var)
{
    t_sym_table *sym = empty_node();
    sym->var = var;
    sym->defined = TRUE;
    printf("sym node called@%p : %s\n", sym, var);
    return sym;
}

t_sym_table *empty_node()
{
    t_sym_table *sym = malloc(sizeof(t_sym_table));
    sym->next = NULL;
    sym->start = sym;
    sym->var = 0;
    sym->defined = FALSE;
    return sym;
}

void debug_sym(t_sym_table *sym, char *hint)
{
    printf("\tdebugging %s\n", hint);
    int i = 0;
    sym = sym->start;
    while (sym != NULL)
    {
        if (i == 0)
        {
            if (sym->defined)
                printf("\t\tstart -> %s  ", sym->var);
            else
                printf("\t\tstart -> udef  ");
        }
        else
        {
            if (sym->defined)
                printf("\t\t[%d] -> %s  ", i, sym->var);
            else
                printf("\t\t[%d] -> udef  ", i);
        }
        printf("\n");
        sym = sym->next;
        i++;
    }
    printf("\n");
}

t_sym_table *find_last(t_sym_table *sym)
{
    printf("find last\n");
    if (sym == NULL)
    {
        printf("sym cannot be null in find_last!");
        exit(4);
    }
    while (sym->next != NULL)
    {
        sym = sym->next;
    }
    return sym;
}

t_sym_table *rt_init()
{
    inital = empty_node();
    return inital;
}

t_sym_table *append_end(t_sym_table *s, t_sym_table *other)
{
    // change all nodes of other's start to s.start
    if (s == NULL || other == NULL)
    {
        printf("\teither s or other are NULL!\n");
        exit(4);
    }
    t_sym_table *this_last = find_last(s);
    this_last->next = other->start;
    t_sym_table *cur = other->start;
    while (cur->next != NULL)
    {
        cur->start = s->start;
        cur = cur->next;
    }
    debug_sym(s, "append end");
    return s;
}

t_sym_table *define_var(t_sym_table *table, t_sym_table *lhs, t_sym_table *rhs)
{
    // we need lhs to not be defined yet and all of rhs be defined
    // we return lhs since that is now defined
    // lhs->var has to be defined
    //lookup_sym(table, lhs, lhs->var, FAIL_IF_FOUND);
    check(table, lhs, FAIL_IF_FOUND);
    check(table, rhs, SUCCEED_IF_FOUND);
    // we have not found lhs but found all of rhs, so we return lhs
    return lhs;
}
t_sym_table *assign(t_sym_table *table, t_sym_table *lhs, t_sym_table *rhs)
{
    printf("\t lhs %d", lhs->defined);
    check(table, lhs, SUCCEED_IF_FOUND);
    printf("\t rhs %d", rhs->defined);
    check(table, rhs, SUCCEED_IF_FOUND);
    return lhs;
}

t_sym_table *copy_sym_node(t_sym_table *other)
{
    printf("copy called\n");
    if (other == NULL)
    {
        printf("cannot copy NULL \n");
        exit(4);
    }
    if (other->defined)
    {
        return sym_node(other->var);
    }
    else
    {
        printf("other is not defined, returning empty node\n");
        return empty_node();
    }
    return empty_node("this should not happen");
}

t_sym_table *check(t_sym_table *table, t_sym_table *other, int mode)
{
    // looks for all symbols of other in table with the respective mode.
    printf("check called\n");
    t_sym_table *start = other->start;
    while (start != NULL)
    {
        if (start->defined)
            lookup_sym(table, start, start->var, mode);
        start = start->next;
    }
    return other;
}























void inset(int margin) {
    for(int i = 0; i < margin; i++)
        printf("\t");
}


const int TREE_SIZE_DEFAULT = 10;
SymbolTree* newTree(variable var) {
    SymbolTree* tree = malloc(sizeof(SymbolTree));
    tree->var = var;
    tree->size = TREE_SIZE_DEFAULT;
    tree->count = 0;
    tree->childIndex = 0;
    tree->parent = NULL;
    tree->children = malloc(sizeof(SymbolTree) * tree->size);
    return tree;
}

SymbolTree* addChild(SymbolTree* tree, SymbolTree* child) {
    // check if there is enough room in tree
    if(tree == NULL || child == NULL)
        exit(101);
    if(tree->count < tree->size) {
        tree->children[tree->count] = child;
        child->childIndex = tree->count;
        tree->count++;
        child->parent = tree;
    } else {
        // we must now realloc 
        const int tmp_size = tree->size * 2;
        SymbolTree** expanded = realloc(tree->children, tmp_size);
        if(expanded == NULL) {
            printf("was not able to realloc, exiting ... \n");
            exit(101);
        } else {
            tree->children = expanded;
            tree->size = tmp_size;
            addChild(tree, child);
        }
    }
    return tree;
}

SymbolTree* single(variable var) {
    SymbolTree* tree = malloc(sizeof(SymbolTree));
    tree->var = var;
    tree->size = 1;
    tree->count = 0;
    tree->childIndex = 0;
    tree->parent = NULL;
    tree->children = malloc(sizeof(SymbolTree) * tree->size);
    printf("Single created @%p : %s\n", tree, var);
    return tree;
}

SymbolTree* root(SymbolTree* sym) {
    for(; sym->parent != NULL; sym = sym->parent);
    return sym;
}

void debugSymTree(SymbolTree* tree, int depth) {
    inset(depth);
    printf("--%s[%d]\n", tree->var, tree->childIndex);
    for(int i = 0; i < tree->count; i++) {
        debugSymTree(tree->children[i], depth + 1);
    }
}

SymbolTree* addChildren(SymbolTree* tree, SymbolTree* parent_of_childs) {
    for(int i = 0; i < parent_of_childs->count; i++)
        addChild(tree, parent_of_childs->children[i]);
    validate(tree); // check for redclaration
    return tree;
}

// looks for var in the tree above and to the left i.e occouring before the node of tree
// exit(3) if var is not found
void lookup_node(SymbolTree* tree, variable var) {
    // we go up one level and look to the left first, then recusivly go up until parent = NULL
    if(tree->parent == NULL) {
        printf("%s has not been declared\n", var);
        exit(3);
    } else {
        if(strcmp(var, tree->parent->var) == 0)
            return; // parent is node we are looking for
    }
    for(int i = 0; i < tree->childIndex; i++) {
        variable cur = tree->parent->children[i]->var;
        if(strcmp(cur, var) == 0) {
            return;     // we have found the node so we stop looking for it.
        }
    }
    lookup_node(tree->parent, var);
}
// validates the current level to check if any variable is declared twice
// retruns the tree if successful or exit(3) otherwise 
void validate(SymbolTree* tree) {
    if(tree->count <= 1)
        return;
    
    for(int i = 0; i < tree->count - 1; i++) {
        variable needle = tree->children[i]->var;
        for(int j = (i + 1); j < tree->count; j++) {
            variable cur = tree->children[j]->var;
            if(strcmp(needle, cur) == 0) {
                printf("%s was redeclared!\n", needle, cur);
                exit(4);
            }
        }
    }
}
