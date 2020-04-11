#include "scope.h"
#include <stdio.h>
#include <stdlib.h>

#define DEBUG_SCOPE 1
#define SEMANTIC_VALIDATE

void criticalFailure(int exitCode, char* msg) {
    #ifdef SEMANTIC_VALIDATE
        printf(msg);
        exit(exitCode);
    #else
        printf("this is a NO-OP");
        printf(msg);
    #endif
}

void criticalNoMSG(int exitCode) {
    criticalFailure(exitCode, "error");
}

void inset(int margin) {
    for(int i = 0; i < margin; i++)
        printf("\t");
}


SymbolTree* _create(int size, MetaType type, variable var) {
    SymbolTree* tree = malloc(sizeof(SymbolTree));
    tree->var = var;
    tree->size = size;
    tree->count = 0;
    tree->childIndex = 0;
    tree->line = 0;
    tree->parent = NULL;
    tree->type = type;
    tree->children = malloc(sizeof(SymbolTree) * tree->size);
    for(int i = 0; i < tree->size; i++)
        tree->children[i] = NULL;
    return tree;
}

SymbolTree* metaNode(MetaType type) {
    switch (type)
    {
    case None:
        /* code */
        printf("call single or newTree instead! ... \n");
        return _create(2, type, "!MetaNone");
    case Statement:
        return _create(10, type, "!Statements");
    case Loop:
        return _create(10, type, "!Loop");
    case If:
        return _create(10, type, "!If");
    case Assignment:
        return _create(1, type, "!Assignment");
    case Loopref:
        return _create(1, type, "!Loopref");
    case ExpressionStatement:
        return _create(1, type, "!Expr");
    case Return:
        return _create(1, type, "!Return");
    default:
        printf("meta type not found ... fatal \n");
        criticalNoMSG(100);
    }
}

SymbolTree* returnNode() {
    return metaNode(Return);
}

SymbolTree* loopNode(SymbolTree* curnode){
    curnode->type = Loop;
    return curnode;
}

SymbolTree* loopRefNode(SymbolTree* node) {
    return addChild(
        metaNode(Loopref),
        node
    );
}

const int TREE_SIZE_DEFAULT = 10;
SymbolTree* newTree(variable var) {
    SymbolTree* tree = _create(TREE_SIZE_DEFAULT, None, var);
    //printf("new Tree created @%p : %s\n", tree, var);
    return tree;
}

SymbolTree* newTree2(variable var, int lineno) {
    SymbolTree* t = newTree(var);
    t->line = lineno;
    return t;
}

SymbolTree* single(variable var) {
    SymbolTree* tree = _create(1, None, var);
    //printf("Single created @%p : %s\n", tree, var);
    return tree;
}

SymbolTree* single2(variable var, int lineno) {
    SymbolTree* t = single(var);
    t->line = lineno;
    return t;
}

SymbolTree* function(SymbolTree* sym) {
    sym->type = Funcdef;
    return sym;
}

SymbolTree* addChild(SymbolTree* tree, SymbolTree* child) {
    // check if there is enough room in tree
    if(child == NULL) {
        printf("skipping addChild ... child is null\n");
        return tree;
    }
    if(tree == NULL) {
        printf("Tree was null fatal ... \n");
        criticalNoMSG(10);
    }
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
            criticalNoMSG(10);
        } else {
            tree->children = expanded;
            tree->size = tmp_size;
            addChild(tree, child);
        }
    }
    return tree;
}


SymbolTree* root(SymbolTree* sym) {
    for(; sym->parent != NULL; sym = sym->parent);
    return sym;
}

void debugSymTree(SymbolTree* tree, int depth) {
    if(!DEBUG_SCOPE)
        return;
    inset(depth);
    printf("--%s[%d], line %d", tree->var, tree->childIndex, tree->line);
    if(tree->type == Loop)
        printf(" (LOOP) ");
    printf("\n");
    for(int i = 0; i < tree->count; i++) {
        debugSymTree(tree->children[i], depth + 1);
    }
}

SymbolTree* addChildren(SymbolTree* tree, SymbolTree* parent_of_childs) {
    return addChildrenMode(tree, parent_of_childs, TRUE);
}

SymbolTree* addChildrenMode(SymbolTree* tree, SymbolTree* parent_of_childs, boolean validate_tree) {
    for(int i = 0; i < parent_of_childs->count; i++)
        addChild(tree, parent_of_childs->children[i]);
    if(validate_tree)
        validate(tree); // check for redclaration
    return tree;
}

// looks for var in the tree above and to the left i.e occouring before the node of tree
// true if found, false otherwis
boolean lookup_node(SymbolTree* tree, variable var) {
    // we go up one level and look to the left first, then recusivly go up until parent = NULL
    if(tree->parent == NULL) {
        //printf("%s has not been declared\n", var);
        //exit(3);
        return FALSE;
    } else {
        if(strcmp(var, tree->parent->var) == 0)
            return TRUE; // parent is node we are looking for
    }
    for(int i = 0; i < tree->childIndex; i++) {
        variable cur = tree->parent->children[i]->var;
        if(strcmp(cur, var) == 0) {
            return TRUE;     // we have found the node so we stop looking for it.
        }
    }
    return lookup_node(tree->parent, var);
}
// validates the current level to check if any variable is declared twice
// retruns the tree if successful or exit(3) otherwise 
SymbolTree* validate(SymbolTree* tree) {
    if(tree->count <= 1)
        return tree;

    for(int i = 0; i < tree->count - 1; i++) {
        SymbolTree* current = tree->children[i];
        variable needle = current->var;
        for(int j = (i + 1); j < tree->count; j++) {
            SymbolTree* other = tree->children[j];
            variable cur = other->var;
            if(strcmp(needle, cur) == 0 && other->type == None && current->type == None) {
                printf("%s was redeclared! \n", needle, cur);
                criticalNoMSG(3);
            }
        }
    }

    return tree;
}

// subtree is basically just a list subtree should also be a root 
SymbolTree* checkSubtreeDeclared(SymbolTree* tree, SymbolTree* subtree) {
    // we could optimize here
    for(int i = 0; i < subtree->count; i++) {
        SymbolTree* current = subtree->children[i];
        boolean res = lookup_node(tree, current->var);
        if(!res) {
            // child[i] is not declared
            printf("Error: %s use before declartation @line:%d\n", current->var, current->line);
            criticalNoMSG(3);
        }
        // we perform a lookup for each node in the subtree but we only check the level below the root node
    }
    return tree;    // return the current tree level
}

void checkDeclared(SymbolTree* tree, variable var) {
    boolean res = lookup_node(tree, var);
    if(!res) {
        // child[i] is not declared
        printf("Error: %s use before declartation\n", var);
        criticalNoMSG(3);
    } 
}

void checkLooprefCorrect(SymbolTree* node) {
    variable lookingfor = node->var;
    int lineno = node->line;
    for(; node->parent != NULL; node = node->parent) {
        if(node->type == Loop) {
            if(strcmp(lookingfor, node->var) == 0)
                return; // we have found a loop and its labels do match.
        }
    }
    // we have not found what we are looking for so we throw a semantic error
    printf("%s is not within a loop of %s @line:%d", lookingfor, lookingfor, lineno);
    criticalNoMSG(3);
}
