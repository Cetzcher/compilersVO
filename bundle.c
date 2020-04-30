#include <stdio.h>
#include <stdlib.h>
// make && ./parser < complex.0 > res.s && gcc res.s bundle.c && ./a.out
// ssh u11810749@g0.complang.tuwien.ac.at
extern long long f(long long *a, long long *b);

int main() {
    long long* addr1 = malloc(sizeof(long long)); 
    long long* addr2 = malloc(sizeof(long long));
    *addr1 = 100;
    *addr2 = 200; 
    printf("addr1: %p, val: %lld\n", addr1, *addr1);
    printf("addr2: %p, val: %lld\n", addr2, *addr2);
    printf("calling f with f(1, 2) res = %lld\n", f(1, 2));
}