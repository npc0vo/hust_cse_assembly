#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

extern int GCD(int a, int b);

int main() {
    int a, b;

    printf("Please input two number to cal GCD£º");
    scanf("%d %d", &a, &b);

    int gcd_num= GCD(a, b);

    // Êä³ö½á¹û
    printf("gcd of %d and %d is£º%d\n", a, b, gcd_num);

    return 0;
}
