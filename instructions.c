#include "instructions.h"
#include <stdlib.h>
#include <stdio.h>

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

void init_codegen(SymbolTree* rootlevel) {
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
    const int reservedSpace = function->parameters + function->declaredVars;
    // reserve space on the stack
    // save call frame
    printf("\tPUSHQ %s \t\t# make room for basepointer\n", basepointer);
    printf("\tMOVQ %s, %s \t# set frame pointer\n", stackpointer, basepointer);
    // make room for local variables
    if(reservedSpace)
        printf("\tSUBQ $%d %s \t\t# reserve space for %d vars\n", (reservedSpace) * 8, stackpointer, reservedSpace);
    // move params onto stack
    for(int i = 0; i < function->parameters; i++) {
        printf("\tMOVQ %s, -%d(%s)\n", argumentRegister[i], 8 * (i + 1), basepointer);
    }
    printf("\n");
}

void generate_return() {
    printf("\tleave \t\t\t# leave function  \n");
}
