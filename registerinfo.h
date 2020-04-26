
#ifndef REGISTERINFO_H_
#define REGISTERINFO_H_

typedef struct reginfo {
    int isfree;
    char* name;
} reginfo;

void initregs();

reginfo getNextFree();
reginfo* getArgRegister(int arg);
reginfo* getRAX();




#endif