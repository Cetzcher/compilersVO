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
    OP_AND = 10,
    OP_NOT = 11,
    OP_MEMACESS = 12
};

void init_codegen();
void declare_func(SymbolTree* function);
void generate_return();
void finalize(SymbolTree* node);
void add(SymbolTree* res, SymbolTree* left, SymbolTree* right);
void addc(SymbolTree* res, SymbolTree* arg, SymbolTree* constant);
void addcr(SymbolTree* res, SymbolTree* arg, SymbolTree* constant);
void mul(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs);
void mulc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant);
void mulcr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg );
void and(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs);
void andc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant);
void andcr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg );
void minus(SymbolTree* res, SymbolTree* lhs);
void not(SymbolTree* res, SymbolTree* lhs);
void memacess(SymbolTree* res, SymbolTree* lhs);
void memacessc(SymbolTree* res, SymbolTree* lhs);
void lessthan(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs);
void lessthanc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant);
void lessthancr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg);
void notequal(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs);
void notequalc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant);
void notequalcr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg);

#endif