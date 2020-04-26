#include "instructions.h"
#include "registerinfo.h"
#include <stdlib.h>
#include <stdio.h>

// this is maybe the worst code in this entire program but it is also magic
// we set lhs if lhs is linked otherwise we use it as is.
#define LINK_VARS lhs = lhs->link == NULL ? lhs: lhs->link; rhs = rhs->link == NULL ? rhs : rhs->link;
#define LINK_UNARY lhs = lhs->link == NULL ? lhs: lhs->link;
#define REG(p) ((p)->assignedRegister->name)
#define REG_FREE(p) ((p)->assignedRegister->isfree)

const char* argumentRegister[6] = {
    "rdi",
    "rsi",
    "rdx",
    "rcx",
    "r8",
    "r9"
};

const char* stackpointer = "%rsp";
const char* basepointer = "%rbp";
const char* rsi_reg = "%rsi";
int rsi_used = 0;


void init_codegen(SymbolTree* rootlevel) {
    initregs();
    printf(".text\n");
    for(int i = 0; i < rootlevel->count; i++) {
        char* name = rootlevel->children[i]->var;
        printf(".globl %s\n", name);
        printf("\t .type %s, @function\n", name);
    }
}

void declare_func(SymbolTree* function) {
    printf("\n\t##    Function      ##\n");
    printf("%s:\n", function->var);
    printf("\t# %s (varcount %d, parmcount %d)\n", function->var, function->parameters, function->declaredVars);
    const int reservedSpace = function->declaredVars;
    // reserve space on the stack
    // save call frame
    printf("\tPUSHQ %s \t\t# make room for basepointer\n", basepointer);
    printf("\tMOVQ %s, %s \t# set frame pointer\n", stackpointer, basepointer);
    // make room for local variables
    if(reservedSpace)
        printf("\tSUBQ $%d, %s \t\t# reserve space for %d vars\n", (reservedSpace) * 8, stackpointer, reservedSpace);
    // move params onto stack
    for(int i = 0; i < function->parameters; i++) {
        // functions children 0 to 'parameters' will be our arguments as nodes
        // we can therfore give them the correct register
        reginfo* argreg = getArgRegister(i + 1); 
        argreg->isfree = 0;
        SymbolTree* argnode = function->children[i];
        argnode->assignedRegister = argreg;
        //printf("argnode pointer %p, name %s, reg %s, regpointer %p\n", argnode, argnode->var, argnode->assignedRegister->name, argnode->assignedRegister);
    }
    printf("\n");
}

void finalize(SymbolTree* node) {
    // we finalize the function by moving the value into rax or, if the register is already rax doing nothing
    reginfo* reg = node->assignedRegister;
    reginfo* rax = getRAX();
    if(reg == rax)
        printf("\t#value is already in rax\n");
    else
        printf("\tMOVQ %%%s, %%rax\n", reg->name);
}

void generate_return() {
    printf("\tleave \t\t\t# leave function  \n");
    printf("\tret\n");
}

void clear() {
    rsi_used = 0;
}

void baserelative(int x) {
    printf(" -%d(%s) ", x * 8, basepointer);
}

void move(char* from, char* to) {
    printf("\tMOVQ %s, %s\n", from, to);
}
void moverel(char* from, int offset, char* to) {
    printf("\tMOVQ -%d(%s), %s\n", offset * 8, from, to);
}


void add(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    reginfo* target = getTempReg();
    if(target != NULL) {
        res->assignedRegister = target;
        target->isfree = 0;
        printf("\tMOVQ %%%s, %%%s\n", lhs->assignedRegister->name, target->name);
        printf("\tADDQ %%%s, %%%s\n", rhs->assignedRegister->name, target->name);
        rhs->assignedRegister->isfree = 1;

    } else {
        printf("\tADDQ %%%s, %%%s\n", lhs->assignedRegister->name, rhs->assignedRegister->name);
        res->assignedRegister = rhs->assignedRegister;
    }
    lhs->assignedRegister->isfree = 1;

}
void addc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant) {
    LINK_UNARY
    printf("\tADDQ $%d, %%%s\n", constant->value, REG(lhs));
    res->assignedRegister = lhs->assignedRegister;
}
void addcr(SymbolTree* res,  SymbolTree* constant, SymbolTree* arg) { addc(res, arg, constant); }



void mul(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    // we move left into rax
    // we then mult with right and free both registers again
    reginfo* rax = getRAX();
    rax->isfree = 0;                // mark occoupied
    res->assignedRegister = rax;
    printf("\tMOVQ %%%s, %%rax\n", lhs->assignedRegister->name);
    printf("\tMULQ %%%s\n", rhs->assignedRegister->name);
    lhs->assignedRegister->isfree = 1;
    rhs->assignedRegister->isfree = 1;
}

void and(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    reginfo* target = getTempReg();
    if(target != NULL) {
        res->assignedRegister = target;
        target->isfree = 0;
        printf("\tMOVQ %%%s, %%%s\n", lhs->assignedRegister->name, target->name);
        printf("\tANDQ %%%s, %%%s\n", rhs->assignedRegister->name, target->name);
        rhs->assignedRegister->isfree = 1;

    } else {
        printf("\tANDQ %%%s, %%%s\n", lhs->assignedRegister->name, rhs->assignedRegister->name);
        res->assignedRegister = rhs->assignedRegister;
    }
    lhs->assignedRegister->isfree = 1;
}

void minus(SymbolTree* res, SymbolTree* lhs) {
    LINK_UNARY
    res->assignedRegister = lhs->assignedRegister;
    printf("\tNEGQ %%%s\n", REG(lhs));
}

void not(SymbolTree* res, SymbolTree* lhs) {
    LINK_UNARY
    res->assignedRegister = lhs->assignedRegister;
    printf("\tNOTQ %%%s", REG(lhs));
}