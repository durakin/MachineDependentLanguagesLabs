/*
 * Illustrates how to call the sum function we wrote in assembly language.
 */

#include <stdio.h>
#include <inttypes.h>

double sqrtt(double);

int main() {
    double arg = 14.88;
    printf("%20.7f\n", sqrtt(arg));
    return 0;
}
