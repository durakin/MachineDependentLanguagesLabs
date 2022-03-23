#include <stdio.h>
#include <inttypes.h>

double var11(double, double);

int main() {
    printf("%20.7f\n", var11(14.88, 5));
    printf("%20.7f\n", var11(4.0, 5));
    printf("%20.7f\n", var11(2.65, 5));
    printf("%20.7f\n", var11(-14.88, 5));
    printf("%20.7f\n", var11(-2, 5));

    return 0;
}
