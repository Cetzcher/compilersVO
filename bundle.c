#include <stdio.h>
// make && ./parser < complex.0 > res.s && gcc res.s bundle.c && ./a.out
// ssh u11810749@g0.complang.tuwien.ac.at
extern long long f(long long a, long long b);

int main() {
    printf("calling f with f(1, 2) res = %lld\n", f(1, 2));
}