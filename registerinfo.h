
#ifndef REGISTERINFO_H_
#define REGISTERINFO_H_

typedef struct reginfo {
    int isfree;
    char* name;
} reginfo;

void initregs();

reginfo* getNextFree();
reginfo* getArgRegister(int arg);
reginfo* getRAX();
reginfo* getR11();
reginfo* getTempReg();
reginfo* getTempNotRAX();
char* createLable();
reginfo* memreg(int pos);
// instructions for controlling registers are here
void emit(char* instr, reginfo* src, reginfo* dest);
void emit_movq(reginfo* src, reginfo* dest);
void emit_const_movq(long long val, reginfo* dest);
void emit_cmp(reginfo* src, reginfo* dest);
void emit_cmp(reginfo* src, reginfo* dest);
void emit_const_cmp(long long val, reginfo* dest);
#endif