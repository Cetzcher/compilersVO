#include "registerinfo.h"
#include <stdlib.h>
#include <stdio.h>


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

reginfo* getRBX() {
    return &rbx;
}

reginfo* getR11() {
    return &r11;
}

reginfo* getTempReg() {
    if(rax.isfree)
        return &rax;
    else if(rbx.isfree)
        return &rbx;        // need to save rbx at some point
    else if(r10.isfree)
        return &r10;
    return NULL;
}

reginfo* memreg(int pos) {
    reginfo* reg = malloc(sizeof(reginfo));
    int offset = 8 * (pos + 1);
    int numdigits = (offset / 10) + 1;
    char* buf;
    snprintf(buf, numdigits + 8, "-%d(%%rbp)", offset);
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


void emit(char* instr, reginfo* src, reginfo* dest) {
    char* sname = src->name;
    char* dname = dest->name;
    printf("\t%s ", instr);
    if(sname[0] == '-')
        printf("%s, ", sname);
    else
        printf("%%%s, ", sname);
    if(dname[0] == '-')
        printf("%s", dname);
    else
        printf("%%%s", dname);
    printf("\n");
}

void emit_movq(reginfo* src, reginfo* dest) {
    emit("movq", src, dest);
}

void emit_const_movq(long long val, reginfo* dest) {
    // TODO: remove this abomination.
    if(dest->name[0] == '-') {
        printf("\tmovq $%lld, %s\n", val, dest->name);
    } else {
        printf("\tmovq $%lld, %%%s\n", val, dest->name);
    }
}