/*
 * Illustrates how to call the sum function we wrote in assembly language.
 */

#include <stdio.h>
#include <inttypes.h>

double tpx(double);

int main() {
    printf("%20.7f\n", tpx(14.88));
    return 0;
}
