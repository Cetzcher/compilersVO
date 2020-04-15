#ifndef INSTRUCTIONS_H
#define INSTRUCTIONS_H
#include "scope.h"

extern const char* argumentRegister[6];

enum Ops {
    OP_NOP = 0,
    OP_PLUS = 1,
    OP_MINUS = 2,
    OP_NUM = 3,
    OP_VAR = 4,
    OP_ZERO = 5,
    OP_ONE = 6,
    OP_MULT = 7,
    OP_HASH = 8,
    OP_LTEQ = 9,
    OP_AND = 10
};

void init_codegen();
void declare_func(SymbolTree* function);
void generate_return();

#endif