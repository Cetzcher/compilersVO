#include "instructions.h"
#include "registerinfo.h"
#include <stdlib.h>
#include <stdio.h>

// this is maybe the worst code in this entire program but it is also magic
// we set lhs if lhs is linked otherwise we use it as is.
#define LINK_VARS lhs = lhs->link == NULL ? lhs: lhs->link; rhs = rhs->link == NULL ? rhs : rhs->link;
#define LINK_UNARY lhs = lhs->link == NULL ? lhs: lhs->link;
#define SYMREG(p) ((p)->assignedRegister)
#define REG(p) ((p)->assignedRegister->name)

const char* stackpointer = "%rsp";
const char* basepointer = "%rbp";


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
    printf("\t# %s (no. of params: %d, declared vars: %d)\n", function->var, function->parameters, function->declaredVars);
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
    // TOOD: this breaks if we just return arg;
    node = node->link == NULL ? node : node->link;
    reginfo* rax = getRAX();
    if(SYMREG(node) == rax)
        printf("\t#value is already in rax\n");
    else
        emit_movq(SYMREG(node), getRAX());
}

void generate_return() {
    printf("\tleave \t\t\t# leave function  \n");
    printf("\tret\n");
}



// perform binary operation, expects lhs and rhs to be linked
// either uses a temp register or uses the same register
void __binop(char* op, SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    reginfo* target = getTempReg();
    if(target != NULL) {
        res->assignedRegister = target;
        target->isfree = 0;
        rhs->assignedRegister->isfree = 1;
        emit_movq(SYMREG(lhs), target);
        emit(op, SYMREG(rhs), target);

    } else {
        emit(op, SYMREG(lhs), SYMREG(rhs));
        res->assignedRegister = rhs->assignedRegister;
        printf("\t# target == NULL");
    }
    lhs->assignedRegister->isfree = 1;
}

void __unaryop(char* op, SymbolTree* res, SymbolTree* lhs) {
    // TODO: since this modifies registers in place it could break lots of stuff!!!
    reginfo* target = getTempReg();
    emit_movq(SYMREG(lhs), target);
    printf("\t%s %%%s\n", op, target->name);
    __freeandset(lhs, NULL, res, target);
}

void __freeandset(SymbolTree* lhs, SymbolTree* rhs, SymbolTree* res, reginfo* target) {
    lhs->assignedRegister->isfree = 1;
    if(rhs != NULL)
        rhs->assignedRegister->isfree = 1;
    res->assignedRegister = target;
    target->isfree = 0;
}


void add(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    __binop("ADDQ", res, lhs, rhs);
}

void imadd(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    // lhs is reg
    // rhs is constant
    
}

void imaddc(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {

}

void addc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant) {
    LINK_UNARY
    reginfo* target = getTempReg();
    emit_movq(SYMREG(lhs), target); 
    if(constant->value != 0)
        printf("\tADDQ $%lld, %%%s\n", constant->value, target->name);
    __freeandset(lhs, NULL, res, target);
}

void addcr(SymbolTree* res,  SymbolTree* constant, SymbolTree* arg) { addc(res, arg, constant); }



void mul(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    __binop("imulq", res, lhs, rhs);
}

void mulc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant) {
    LINK_UNARY
    reginfo* target = getTempReg();
    emit_movq(SYMREG(lhs), target); 
    printf("\timulq $%lld, %%%s\n", constant->value, target->name);
    __freeandset(lhs, NULL, res, target);
}

void mulcr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg ) { mulc(res, arg, constant); }

void and(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    __binop("ANDQ", res, lhs, rhs);
}

void andc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant) {
    LINK_UNARY
    reginfo* target = getTempReg();
    emit_movq(SYMREG(lhs), target);
    printf("\tANDQ $%d, %%%s\n", constant->value, target->name);
    __freeandset(lhs, NULL, res, target);
}

void andcr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg ) { andc(res, arg, constant); }

void minus(SymbolTree* res, SymbolTree* lhs) {
    LINK_UNARY
    __unaryop("NEGQ", res, lhs);
}

void not(SymbolTree* res, SymbolTree* lhs) {
    LINK_UNARY
    __unaryop("NOTQ", res, lhs);
}

void memacess(SymbolTree* res, SymbolTree* lhs) {
    LINK_UNARY
    reginfo* target = getTempReg();
    if(target != NULL) {
        printf("\tMOVQ (%%%s), %%%s\n", REG(lhs), target->name);   // move data at adress to target
        target->isfree = 0;
        lhs->assignedRegister->isfree = 1;
        res->assignedRegister = target;
    } else {
        printf("\tMOVQ (%%%s), (%%%s)\n");
        res->assignedRegister = lhs->assignedRegister;
    }
}
void memacessc(SymbolTree* res, SymbolTree* lhs) {
    reginfo* target = getTempReg();
    if(target == NULL) {
        printf("?????\n");
    } else {
        res->assignedRegister = target;
        target->isfree = 0;
        printf("\tLEAQ $%d, %%%s\n", lhs->value, REG(res));
    }
}

void lessthan(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    // check if lhs <= rhs
    // ie if lhs =src2 - rhs=src1 >= 0 set -1 otherwise set 0
    reginfo* target = getTempReg();
    char* lab = createLable();
    char* comparefin = createLable();
    printf("\tcmp %%%s, %%%s\n", REG(rhs), REG(lhs));   
    printf("\tjge %s\n", lab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\tjmp %s\n", comparefin);
    printf("\t%s:\n", lab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\t%s:\n", comparefin);
    __freeandset(lhs, rhs, res, target);
}
void lessthanc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant) {
    LINK_UNARY
    reginfo* target = getTempReg();
    char* lab = createLable();
    char* comparefin = createLable();
    printf("\tcmp $%lld, %%%s\n", constant->assignedRegister, REG(lhs));   
    printf("\tjge %s\n", lab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\tjmp %s\n", comparefin);
    printf("\t%s:\n", lab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\t%s:\n", comparefin);
    __freeandset(lhs, NULL, res, target);
}

void lessthancr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg) {
    lessthanc(res, arg, constant);   
    // we need to invert our result so we generate a NOTQ instruction afterwards
    printf("\tnotq %%%s\n", res->assignedRegister->name);
}

void notequal(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    reginfo* target = getTempReg();
    char* eqlab = createLable();
    char* aftercompare = createLable();
    printf("\ttest %%%s, %%%s\n", REG(lhs), REG(rhs));
    printf("\tje %s\n", eqlab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\tjmp %s\n", aftercompare);
    printf("\t%s:\n", eqlab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\t%s:\n", target->name);
    __freeandset(lhs, rhs, res, target);
}
void notequalc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant) {
    LINK_UNARY
    reginfo* target = getTempReg();
    char* eqlab = createLable();
    char* aftercomp = createLable();
    printf("\ttest $%lld, %%%s\n", constant->value, REG(lhs));
    printf("\tje %s\n", eqlab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\tjmp %s\n", aftercomp);
    printf("\t%s:\n", eqlab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\t%s:\n", aftercomp);
    __freeandset(lhs, NULL, res, target);
}

void notequalcr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg) { notequalc(res, arg, constant); }
