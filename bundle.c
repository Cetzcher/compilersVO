#include <stdio.h>
#include <stdlib.h>
// make && ./codea < complex.0 > res.s && gcc res.s bundle.c && ./a.out
// ssh u11810749@g0.complang.tuwien.ac.at
extern long fib(long long a, long long b, long long cnt);
extern long long fib2(long long a, long long b);
extern long long g(long long a, long long b);
extern long long isPrime(long long a);
extern long long divwithrest(long long a, long long b, long long rest[]);
extern long long calltest();

int main() {
    long long a = 10;
    long long b = 2;
    long long a1 = 11;
    long long b1 = 2;
    long long primeNum = 11;
    long long restp[2];
    restp[0] = 100;
    restp[1] = 250;
    long long diva = 14;
    long long divb = 3;

    printf("calling fib with fib(0, 1, 10) res = %lld", fib(0, 1, 10));
    printf("calling g with g(%lld, %lld) res = %lld\n", a1, b1, g(a1, b1));
    printf("calling is prime with isPrime(%lld) res = %lld\n", primeNum, isPrime(primeNum));
    long long res = divwithrest(diva, divb, restp);
    printf("calling divwithrest with divwithrest(%lld, %lld, pointer) res = %lld, rest = %lld\n", diva, divb, res, restp[0]);
    printf("restp[1] == %lld\n", restp[1]);
    printf("calling calltest() res = %lld", calltest());
}