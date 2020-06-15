#include "scope.h"
#include "instructions.h"
#include <stdio.h>
#include <stdlib.h>

#define DEBUG_SCOPE 1
#define SEMANTIC_VALIDATE

void criticalFailure(int exitCode, char* msg) {
    #ifdef SEMANTIC_VALIDATE
        printf(msg);
        exit(exitCode);
    #else
        printf("this is a NO-OP ");
        printf(msg);
    #endif
}

void criticalNoMSG(int exitCode) {
    criticalFailure(exitCode, "error\n");
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
    tree->op = 0;
    tree->memref = 0;
    tree->value = 0;
    tree->parameters = 0;
    tree->declaredVars = 0;
    tree->link = NULL;
    tree->assignedRegister = NULL;
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

SymbolTree* callNode(SymbolTree* n) {
    n->op = OP_CALL;
    return n;
}

SymbolTree* returnNode() {
    return metaNode(Return);
}

// addChildren(loopNode(@LoopHead.sym@), @StmtList.context@);
SymbolTree* loopNode(SymbolTree* loophead, SymbolTree* context) {
    loophead->type = Loop;
    loophead->declaredVars = context->declaredVars;
    return addChildren(loophead, context);
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
    SymbolTree* tree = _create(2, None, var);
    //printf("Single created @%p : %s\n", tree, var);
    return tree;
}

SymbolTree* single2(variable var, int lineno) {
    SymbolTree* t = single(var);
    t->line = lineno;
    return t;
}


// addChildren(addChildren(function(@id.sym@), @ArgList.ids@), @StmtList.context@)
SymbolTree* func(SymbolTree* name, SymbolTree* params, SymbolTree* body) {
    name->type = Funcdef;
    name->parameters = params->parameters;
    SymbolTree* funcParams = addChildren(name, params);
    if(body != NULL) {
        funcParams->declaredVars = body->declaredVars;  // pass the declared varaiables up
        return addChildren(funcParams, body);
    }
    return funcParams;
}

SymbolTree* paramWithOp(SymbolTree* before, SymbolTree* cur, MetaType type) {
    if(before == NULL) {
        if(cur == NULL) {
            return single("!meta");
        }
        cur->parameters = 1;
        cur->memref = 1;
        SymbolTree* parent = single("!meta");
        parent->parameters = cur->parameters;
        parent->memref = cur->memref;
        parent->type = type;
        cur->type = type;
        return addChild(parent, cur);  // create a parent and return that instead
    } 
    // before will now be the parent elem
    cur->parameters = ++before->parameters;
    cur->memref = ++before->memref;
    cur->type = type;
    before->type = type;
    return addChild(before, cur);   // add this as a child
}

SymbolTree* param(SymbolTree* before, SymbolTree* cur) {
    return paramWithOp(before, cur, Param);
}

SymbolTree* exprparam(SymbolTree* before, SymbolTree* cur) {
    if(before == NULL) {
        if(cur == NULL) {
            return single("!meta");
        }
        cur->parameters = 1;
        SymbolTree* parent = single("!meta");
        parent->parameters = cur->parameters;
        parent->memref = cur->memref;
        return addChild(parent, cur);  // create a parent and return that instead
    } 
    // before will now be the parent elem
    cur->parameters = ++before->parameters;
    return addChild(before, cur);   // add this as a child
}

SymbolTree* decl(SymbolTree* node) {
    node->declaredVars = 1;
    node->type = Variable;
    return node;
}

SymbolTree* statements(SymbolTree* lhs, SymbolTree* rhs) {
    if(rhs == NULL) {
         SymbolTree* par = addChild(metaNode(Statement), lhs);
         par->declaredVars = lhs->declaredVars;
         return par;
    }
    addChild(lhs, rhs);
    lhs->declaredVars += rhs->declaredVars;
    return lhs;
}

SymbolTree* num(long val) {
    SymbolTree* node = _create(2, None, NULL);
    node->op = OP_NUM;
    node->value = val;
    return node;
}

SymbolTree* ID(SymbolTree* sym) {
    sym->op = OP_VAR;
    sym->type = Variable;
    return sym;
}

SymbolTree* exprnode(SymbolTree* left, SymbolTree* op, SymbolTree* right) {
    if(op == NULL && right == NULL)
        return left;
    addChild(op, left);
    addChild(op, right);
    SymbolTree* sym = root(op);
    sym->type = OpNode;
    return sym;
}

SymbolTree* opnode(int op, SymbolTree* child) {
    SymbolTree* node = _create(2, OpNode, NULL);
    node->op = op;
    addChild(node, child);
    return node;
}

SymbolTree* oplist(SymbolTree* lst, SymbolTree* head) {
    if( head == NULL)
        criticalFailure(4, "op node is null  in oplist(Symtree, Symtree)");
    if(lst == NULL)
        return head;
    if(lst->op == head->op && (lst->op == OP_NOT || lst->op == OP_MINUS)) {
        // prune the list here
        return NULL;
    }
    addChild(lst, head);
    return head;
}

SymbolTree* ifThenElse(SymbolTree* ifpath, SymbolTree* elsepath) {
    int maxVars = ifpath->declaredVars > elsepath->declaredVars ? ifpath->declaredVars : elsepath->declaredVars;
    SymbolTree* ifmetanode = addChild(addChild(metaNode(If), ifpath), elsepath);
    ifmetanode->declaredVars = maxVars; 
    return ifmetanode;
}

SymbolTree* addChild(SymbolTree* tree, SymbolTree* child) {
    // check if there is enough room in tree
    if(child == NULL) {
        // TODO: might be helpful to actually have a logger or something for stuff like this and produce proper debug output
        //printf("skipping addChild ... child is null\n");
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
        const int tmp_size = tree->size + TREE_SIZE_DEFAULT;
        SymbolTree** expanded = realloc(tree->children, sizeof(SymbolTree*) * tmp_size);
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
    printNode(tree);
    for(int i = 0; i < tree->count; i++) {
        debugSymTree(tree->children[i], depth + 1);
    }
}

void printNode(SymbolTree* node) {
    if(!DEBUG_SCOPE)
        return;
    if(node->var)
        printf("#--%s[%d], line %d @%d  ", node->var, node->childIndex, node->line, node->memref);
    else
        printf("#--???  ");

    if(node->type == Loop)
        printf(" (LOOP) ");
    else if(node->type == Funcdef)
        printf("Funcdef (parmcount: %d)", node->parameters);
    else if(node->op == OP_NUM)
        printf("NUM <%d>", node->value);
    else if (node->type == OpNode)
        printf("Operator (%d)", node->op);
    else if (node->op == OP_VAR)
        printf("var");
    
    printf(" Type: (%d)", node->type);
    printf(" addr: %p", node);
    printf(" Is linked? [%s]", node->link == NULL  ? "NO" : "YES" );
    printf("\n");
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

SymbolTree* lookupInternal(SymbolTree* tree, variable var) {
    // we go up one level and look to the left first, then recusivly go up until parent = NULL
    if(tree->parent == NULL || var == NULL) {
        //printf("%s has not been declared\n", var);
        //exit(3);
        return NULL;
    } 

    for(int i = 0; i < tree->childIndex; i++) {
        variable cur = tree->parent->children[i]->var;
        if(strcmp(cur, var) == 0) {
            return tree->parent->children[i];     // we have found the node so we stop looking for it.
        }
    }
    // we check the parent last since it is always to the "left" of the siblings in code
    if(strcmp(var, tree->parent->var) == 0)
        return tree->parent; // parent is node we are looking for
    return lookupInternal(tree->parent, var);
}
// looks for var in the tree above and to the left i.e occouring before the node of tree
// true if found, false otherwis
boolean lookup_node(SymbolTree* tree, variable var) {
    return lookupInternal(tree, var) != NULL;
}

// validates the current level to check if any variable is declared twice
// retruns the tree if successful or exit(3) otherwise 
SymbolTree* validate2(SymbolTree* tree) {
    if(tree->count <= 1)
        return tree;


    for(int i = 0; i < tree->count - 1; i++) {
        SymbolTree* current = tree->children[i];
        variable needle = current->var;
        for(int j = (i + 1); j < tree->count; j++) {
            SymbolTree* other = tree->children[j];
            variable cur = other->var;
            if(strcmp(needle, cur) == 0 && (other->type == Variable || other->type == Param) && (current->type == Variable || current->type == Param)) {
                printf("%s was redeclared! \n", needle, cur);
                criticalNoMSG(3);
            }
        }
    }

    return tree;
}

// we want to check each var and see if they already occour in the tree above 
// to do that we use a set and perform breadth first search
// when insert is false then the variable occours twice in the main tree and we throw it away
SymbolTree* validate(SymbolTree* tree) {
    // if we have found a leaf i.e. count = 0
    // then we search for this node up in the tree
    if(tree->count == 0) {
            // check if the node we are looking at is a var node
            if(tree->type == Variable || tree->type == Param) {
                // if it is look it up in the tree above
                SymbolTree* lookup = lookupInternal(tree, tree->var);
                if(lookup != NULL) {
                    if(lookup->type != Funcdef) {
                        printf("**  %s was redeclared at line %d\n", tree->var, tree->line);
                        criticalNoMSG(3);
                    }
                } 
            }
    } else {
        for(int i = 0; i < tree->count; i++) {
            validate(tree->children[i]);
        }
    }

    return tree;
}


// links current symbol in tree if found otherwise throws various errors
void hookVars(SymbolTree* tree, SymbolTree* currentSymbol) {
    if(currentSymbol == NULL)
        criticalFailure(4, "currentSymbol is null, this should not happen in hookVars()\n");
    SymbolTree* link = lookupInternal(tree, currentSymbol->var);
    if(link != NULL){
        // check to see if our found link is a variable or a parameter
        // if so we link them.

        if(link->type == Loop) {
            printf("Error: %s is a label\n", currentSymbol->var);
            criticalNoMSG(3);
        }
        if(link->type == Variable || link->type == Param) {
            if(currentSymbol->link == NULL) { // only link if they have not been linked yet
                currentSymbol->link = link;
            
            }
        } 
    } else {
        // if we cannot find a link the user has not declared the variable beforehand so we quit.
        if(currentSymbol->var == NULL) 
            return;
        printf("Error: %s use before declartation @line:%d\n", currentSymbol->var, currentSymbol->line);
        criticalNoMSG(3);
    }
}

SymbolTree* checkSubtreeDeclared(SymbolTree* tree, SymbolTree* sub) {
    if(sub == NULL)
        criticalFailure(4, "Subtree is null, this should not happen in checkSubtreeDeclared()\n");
    if(sub->type == Variable || sub->type == Param) {
        hookVars(tree, sub);    // check root level
    }
    // iterate every child of sub if they are a variable then hook it otherwise
    // recurse into in depth-first manner.
    for(int i = 0; i < sub->count; i++) {
        SymbolTree* currentSymbol = sub->children[i];
        if(currentSymbol->type == Variable || currentSymbol->type == Param) {
            hookVars(tree, currentSymbol);
        } else {
            checkSubtreeDeclared(tree, currentSymbol);
        }
    }
    return tree;
}

void checkDeclared(SymbolTree* tree, SymbolTree* var) {
    if(var == NULL)
            return;
    SymbolTree* sym = lookupInternal(tree, var->var);
    if(sym == NULL) {
        // child[i] is not declared
        printf("Error: %s use before declartation\n", var);
        criticalNoMSG(3);
    } else if(sym->type == Loop || sym->type == Loopref) {
        printf("Error: %s is used as a Label\n", var);
        criticalNoMSG(3);
    }
    var->link = sym;
}

void checkLooprefCorrect(SymbolTree* node) {
    variable lookingfor = node->var;
    SymbolTree* init = node;
    int lineno = node->line;
    for(; node->parent != NULL; node = node->parent) {
        if(node->type == Loop) {
            if(strcmp(lookingfor, node->var) == 0) {
                init->link = node;  // link the label
                return; // we have found a loop and its labels do match.
            }
        }
    }
    // we have not found what we are looking for so we throw a semantic error
    printf("%s is not within a loop of %s @line:%d", lookingfor, lookingfor, lineno);
    criticalNoMSG(3);
}

void checkLoopUnique(SymbolTree* loop) {
    // check that the loop is unique if not we fail
    SymbolTree* lookup = lookupInternal(loop, loop->var);
    if(lookup != NULL) {
        printf("Loop name is not availible %s\n", loop->var);
        criticalNoMSG(3);
    }
}

