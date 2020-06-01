#include "instructions.h"
#include "registerinfo.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// this is maybe the worst code in this entire program but it is also magic
// we set lhs if lhs is linked otherwise we use it as is.
#define LINK_VARS lhs = lhs->link == NULL ? lhs: lhs->link; rhs = rhs->link == NULL ? rhs : rhs->link;
#define LINK_UNARY lhs = lhs->link == NULL ? lhs: lhs->link;
#define LINK(x) ((x) = ((x)->link) == NULL? (x) : (x)->link)
#define SYMREG(p) ((p)->assignedRegister)
#define REG(p) ((p)->assignedRegister->name)

const char* stackpointer = "%rsp";
const char* basepointer = "%rbp";
const symLinkedList* start;


void init_codegen(SymbolTree* rootlevel) {
    initregs();
    start = createSymLinkedList();
    printf(".text\n");
    for(int i = 0; i < rootlevel->count; i++) {
        char* name = rootlevel->children[i]->var;
        printf(".globl %s\n", name);
        printf("\t .type %s, @function\n", name);
    }
}

void declare_func(SymbolTree* function) {
    printf("%s: ##    Function     (no. of params: %d, declared vars: %d) ##\n", function->var, function->parameters, function->declaredVars);
    const int reservedSpace = function->declaredVars;
    // reserve space on the stack
    // save call frame
    // make room for local variables
    printf("\tPUSHQ %s \t\t# make room for basepointer\n", basepointer);
    printf("\tMOVQ %s, %s \t# set frame pointer\n", stackpointer, basepointer);
    printf("\tPUSHQ %%rbx\n");
    if(reservedSpace) {
        printf("\tSUBQ $%d, %s \t\t# reserve space for %d vars\n", (reservedSpace) * 8, stackpointer, reservedSpace);
    }
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

int memrefInContext = 0;
void assignMemref(SymbolTree* node) {
    // we also want to create a memory "register"
    node->assignedRegister = memreg(memrefInContext);
    node->memref = memrefInContext++;
    setTarget(node->assignedRegister);
}

void instr_assignment(SymbolTree* node) {
    LINK(node);
    setTarget(SYMREG(node));
}

reginfo* targetReg;
void setTarget(reginfo* reg) {
    targetReg = reg;
}

symLinkedList* createSymLinkedList() {
    symLinkedList* lst = malloc(sizeof(symLinkedList));
    lst->next = NULL;
    lst->id = NULL;
    lst->nodes = NULL;
    return lst;
}


void instr_if(SymbolTree* expr, char* endlab) {
    setTarget(getRAX());
    if(burm_label(expr)) {
        burm_reduce(expr, 1);
         // we now have the value we want to compare with in rax
         // we can now test rax, 1 
         printf("\ttest $1, %%rax\n");
         printf("\tjz %s\n", endlab);
    }
}

void instr_ifelse(SymbolTree* context, SymbolTree* expr, char* ifendlab) {
    // we know that an ifelse node has exactly two statements chidren
    // we mark the else node for a label, expr contains the expr we want to test
    char* elsepath = createLable();
    SymbolTree* elsepathnode = context->children[1];
    int len = strlen(elsepath) + strlen(ifendlab) + 8;
    char* instr = malloc(sizeof(char) * len);
    snprintf(instr, len,  "\tjmp %s\n%s:\n", ifendlab, elsepath);
    // we also keep track of how many variables on the stack are used.
    // consider this:
    // if a then var x:= 1; var y:=2 else var p:=3;
    // x should be at 8 * (1 + count), y at 8 * (2 + count) and p again at 8 * (1 + count)
    postponeLabelGen(instr, elsepathnode, memrefInContext);
    setTarget(getRAX());
    if(burm_label(expr)) {
         burm_reduce(expr, 1); 
         // we now have the value we want to compare with in rax
         // we can now test rax, 1  if the number is 0 we have an even number 
         printf("\ttest $1, %%rax\n");
         // if the number is 0 we want to execute the truthy path
         printf("\tjz %s \n", elsepath);  // if not zero then 
         // else we excute the false path
    }
}

void instr_loop(SymbolTree* context, SymbolTree* loop) {
    printf("__%s:\n", loop->var);
    // look for loop in context and postpone end generation to next sibling of loop
    int index;
    for(index = 0; index < context->count; index++) {
        if(context->children[index] == loop)
            break;
    }
    int len = strlen(loop->var) + 7;
    char* endlab = malloc(sizeof(char) * len);
    snprintf(endlab, len, "__end%s:\n", loop);
    postponeLabelGen(endlab, context->children[index + 1], memrefInContext);
}

void instr_statements(SymbolTree* node) {
    // this is a very hacky construct, basically we iterate the symLinkedList and comprae each element with node
    // if we find  it, we delete if from the linked list and insert the associated label. this is done for handeling if else stmts
    // mainly for inserting the else label
    symLinkedList* cur = start;
    while(cur != NULL)
    {
        if(cur->nodes == node) {
            // print the postponed instructions
            // we also set memrefinContext back 
            memrefInContext = cur->memrefcount;
            printf("%s\n", cur->id);
            // remove the node 
            cur->nodes = NULL;
            cur->memrefcount = 0;
            cur->id = NULL;
            return;
        }
        cur = cur->next;
    }
} 

// expr contains the expression we want to put into rax
void instr_memacess(SymbolTree* expr) {
    // we push the value onto the stack momentarily.
    printf("\tpushq %%rax\n");
    // we now perform the labeling and set rax as the target
    setTarget(getRAX());
    if(burm_label(expr)) {
        burm_reduce(expr, 1);
        // we know that our address resides on the stack and that the expression value is in rax
        // we pop the addr into rbx
        printf("\tpopq %%rbx\n");
        printf("\tmovq %%rax, (%%rbx)\n");

      }
}

void postponeLabelGen(char* lab, SymbolTree* node, int memrefcount) {
    // we insert into our symLinkedList if we find a free spot otherwise we grow the list
    symLinkedList* cur;
    for(cur = start; cur->next != NULL; cur = cur->next) {
        if(cur->nodes == NULL) {
            cur->nodes = node;
            cur->id = lab; 
            cur->memrefcount = memrefcount;
            return;
        }
    }
    // we have not found a free spot cur is now the last element, now create a node
    symLinkedList* lstnode = createSymLinkedList();
    lstnode->nodes = node;
    lstnode->id = lab;
    lstnode->memrefcount = memrefcount;
    cur->next = lstnode;
}

void finalize(SymbolTree* node) {
    // we finalize the function by moving the value into rax or, if the register is already rax doing nothing
    node = node->link == NULL ? node : node->link;
    if(node->assignedRegister != targetReg)
        emit_movq(SYMREG(node), targetReg);
    node->assignedRegister->isfree = 1;
    
}
void finalizec(SymbolTree* node) {
    emit_const_movq(node->value, targetReg);
    if(node->assignedRegister != NULL)
        node->assignedRegister->isfree = 1;
}

void generate_return() {
    printf("\tPOPQ %%rbx\n");
    printf("\tleave \t\t\t# leave function  \n");
    printf("\tret\n");
}

// perform binary operation, expects lhs and rhs to be linked
// either uses a temp register or uses the same register
void __binop(char* op, SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    printf("# binop called lhs: %s (%s) rhs: %s\n", REG(lhs), op, REG(rhs));
    reginfo* target = getTempReg();
    emit_movq(SYMREG(lhs), target);
    emit(op, SYMREG(rhs), target);
    printf("# end binop\n");
    __freeandset(lhs, rhs, res, target);
}

void __unaryop(char* op, SymbolTree* res, SymbolTree* lhs) {
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
    setTarget(getRAX());
    // cmp allows only one operand in memory we therefor need to put
    // lhs into rax or some other register
    finalize(lhs);
    emit_cmp(SYMREG(rhs), getRAX());
    printf("\tjg %s\n", lab);
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
    setTarget(getRAX());
    finalize(lhs);
    emit_const_cmp(constant->value, getRAX());
    printf("\tjg %s\n", lab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\tjmp %s\n", comparefin);
    printf("\t%s:\n", lab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\t%s:\n", comparefin);
    __freeandset(lhs, NULL, res, target);
}

void lessthancr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg) {
    // we need to invert our result so we generate a NOTQ instruction afterwards
    LINK(arg);
    reginfo* target = getTempReg();
    char* lab = createLable();
    char* comparefin = createLable();
    setTarget(getRAX());
    finalize(arg);
    emit_const_cmp(constant->value, getRAX());
    printf("\tjl %s\n", lab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\tjmp %s\n", comparefin);
    printf("\t%s:\n", lab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\t%s:\n", comparefin);
    __freeandset(arg, NULL, res, target);
}

void notequal(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_VARS
    reginfo* target = getTempReg();
    char* eqlab = createLable();
    char* aftercompare = createLable();
    setTarget(getRAX());
    // cmp allows only one operand in memory we therefor need to put
    // rhs into rax or some other register
    finalize(rhs);
    emit_cmp(SYMREG(lhs), getRAX());
    printf("\tje %s\n", eqlab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\tjmp %s\n", aftercompare);
    printf("\t%s:\n", eqlab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\t%s:\n", aftercompare);
    __freeandset(lhs, rhs, res, target);
}

void notequalc(SymbolTree* res, SymbolTree* lhs, SymbolTree* constant) {
    LINK_UNARY
    reginfo* target = getTempReg();
    char* eqlab = createLable();
    char* aftercomp = createLable();
    setTarget(getRAX());
    finalize(lhs);
    emit_const_cmp(constant->value, getRAX());
    printf("\tje %s\n", eqlab);
    printf("\tMOVQ $-1, %%%s\n", target->name);
    printf("\tjmp %s\n", aftercomp);
    printf("\t%s:\n", eqlab);
    printf("\tMOVQ $0, %%%s\n", target->name);
    printf("\t%s:\n", aftercomp);
    __freeandset(lhs, NULL, res, target);
}

void notequalcr(SymbolTree* res, SymbolTree* constant, SymbolTree* arg) { notequalc(res, arg, constant); }

char* __chooseInstr(int op) {
    switch (op) {
        case OP_PLUS:
            return "addq";
        case OP_AND: 
            return "andq";
        case OP_MULT:
            return "imulq";
        default:
            return NULL;
    }
}

void imtoreg(SymbolTree* reg, SymbolTree* im) {
    LINK(im);
    LINK(reg);
    reginfo* target = getTempReg();
    char* instr = __chooseInstr(reg->op);
    emit_const_movq(reg->value, target);
    emit(instr, reg->assignedRegister, target);
    reg->assignedRegister->isfree = 1;
    im->assignedRegister->isfree = 1;
    target->isfree = 0;
    reg->assignedRegister = target;
}


void imadd(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    // lhs is im
    // rhs is const
    LINK_UNARY
    res->assignedRegister = lhs->assignedRegister;
    res->value = lhs->value + rhs->value;
}

void immultreg(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    // lhs is reg
    // rhs is const
    LINK_UNARY
    res->assignedRegister = lhs->assignedRegister;
    res->value = rhs->value;
}

void immult(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_UNARY
    res->assignedRegister = lhs->assignedRegister;
    res->value = lhs->value * rhs->value;
}

void imand(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    LINK_UNARY
    res->assignedRegister = lhs->assignedRegister;
    res->value = lhs->value & rhs->value;
}

void imandreg(SymbolTree* res, SymbolTree* lhs, SymbolTree* rhs) {
    // lhs is reg
    // rhs is const
    LINK_UNARY
    res->assignedRegister = lhs->assignedRegister;
    res->value = rhs->value;
}