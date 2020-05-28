#include <stdio.h>
#include <stdlib.h>
// make && ./codea < complex.0 > res.s && gcc res.s bundle.c && ./a.out
// ssh u11810749@g0.complang.tuwien.ac.at
extern long long f(long long* a, long long b);

int main() {
    long long a = 5;
    long long b = 7;
    long long* mem = malloc(sizeof(long long) * 8);
    mem[8] = 0;
    printf("mem before: %lld", mem[8]);
    printf("calling f with f(%lld, %lld) res = %lld\n", a, b, f(mem, b));
    printf("mem after: %lld", mem[8]);
}