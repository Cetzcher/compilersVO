#include "registerinfo.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


reginfo rax ;
reginfo rbx ;
reginfo rdi ;
reginfo rsi ;
reginfo rdx ;
reginfo rcx ;
reginfo r9 ;
reginfo r8;
reginfo r10;
reginfo r11;
short lablecount = 0;

void initregs() {
    rax.isfree = 1; rax.name = "rax";
    rbx.isfree = 1; rbx.name = "rbx";
    rdi.isfree = 1; rdi.name = "rdi";
    rsi.isfree = 1; rsi.name = "rsi";
    rdx.isfree = 1; rdx.name = "rdx";
    rcx.isfree = 1; rcx.name = "rcx";
    r9.isfree = 1;  r9.name = "r9";
    r8.isfree = 1;  r8.name = "r8";
    r10.isfree = 1;  r10.name = "r10";
    r11.isfree = 1;  r11.name = "r11";

}

reginfo* allregs() {
    reginfo* regs = malloc(sizeof(reginfo) * 8);
    regs[0] = rax;
    regs[1] = rbx;
    regs[2] = rdi;
    regs[3] = rsi;
    regs[4] = rdx;
    regs[5] = rcx;
    regs[6] = r9;
    regs[7] = r8;
    return regs;
}

reginfo* getNextFree() {
    reginfo* regs = allregs();
    for(int i = 0; i < 8; i++) {
        if(regs[i].isfree)
            return &regs[i];
    }
    return NULL;
}


reginfo* getArgRegister(int arg) {
    switch (arg)
    {
        case 1: return &rdi; 
        case 2: return &rsi; 
        case 3: return &rdx; 
        case 4: return &rcx; 
        case 5: return &r8; 
        case 6: return &r9; 
    }
}

reginfo* getRAX() {
    return &rax;
}


reginfo* getR11() {
    return &r11;
}

reginfo* getTempReg() {
    if(rax.isfree)
        return &rax;
    else if(r10.isfree)
        return &r10;      
    else if(r11.isfree)
        return &r11;
    return NULL;
}

reginfo* getTempNotRAX() {
    if(r10.isfree)
        return &r10;      
    else if(r11.isfree)
        return &r11;
    return NULL;
}

reginfo* memreg(int pos) {
    reginfo* reg = malloc(sizeof(reginfo));
    int offset = 8 * (pos + 1);
    int numdigits = (offset / 10) + 1;
    int len = numdigits + 8;
    char* buf  = malloc(sizeof(char) * len);
    snprintf(buf, len, "-%d(%%rbp)", offset);
    reg->name = buf;
    reg->isfree = 0;
    return reg;
}

char* createLable() {
    int numlen = (lablecount / 10) + 1;
    // we use __LAB{num}\0  => 5 + numlen + 1 characters
    const int buffersize = (5 + numlen + 1);
    char* name = malloc(buffersize * sizeof(char));
    snprintf(name, buffersize, "__LAB%d", lablecount);
    lablecount++;
    return name;
}

int isMemreg(char* name) {
    return name[0] == '-';
}

void __emit_reg_or_mem(char* name) {
    // if the name starts with a minus we do not want a leading %
    if(isMemreg(name))
        printf("%s", name);
    else
        printf("%%%s", name);
}

void emit(char* instr, reginfo* src, reginfo* dest) {
    if(strcmp(instr, "movq") == 0 && src == dest)
        return;
    printf("\t%s ", instr);
    __emit_reg_or_mem(src->name);
    printf(", ");
    __emit_reg_or_mem(dest->name);
    printf("\n");    
}

void emit_movq(reginfo* src, reginfo* dest) {
    // we cannot perform mov addr, addr
    // so if src is a memreg we move it to rax first
    if(isMemreg(src->name) && isMemreg(dest->name)){
        reginfo* temp = getTempReg();
        emit("movq", src, temp);
        emit("movq", temp, dest);
    } else {
        emit("movq", src, dest);
    }
}

void emit_const_movq(long long val, reginfo* dest) {
    // TODO: remove this abomination.
    if(isMemreg(dest->name)) {
        printf("\tmovq $%lld, %s\n", val, dest->name);
    } else {
        printf("\tmovq $%lld, %%%s\n", val, dest->name);
    }
}

void emit_cmp(reginfo* src, reginfo* dest) {
    if(isMemreg(dest->name)) {
        // if our destination is a memory register we need to 
        // we need to use some other register.
        reginfo* temp = getTempReg();    // this register is only used for the compare instruction
        emit_movq(dest, temp);
        dest = temp;    // we can continue as if our dest register is the temp register.
    }
    emit("cmp", src, dest);
}

void emit_const_cmp(long long val, reginfo* dest) {
        if(isMemreg(dest->name)) {
        // if our destination is a memory register we need to 
        // we need to use some other register.
        reginfo* temp = getTempReg();    // this register is only used for the compare instruction
        emit_movq(dest, temp);
        dest = temp;    // we can continue as if our dest register is the temp register.
    }
    printf("\tcmp $%lld, ", val);
    __emit_reg_or_mem(dest->name);
    printf("\n");
}