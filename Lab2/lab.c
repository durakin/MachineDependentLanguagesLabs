#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

double var11(double, double);

int main(int argc, const char* argv[])
{
    char *eptr;

    if (argc != 3)
    {
        fprintf(stderr, "Expected arguments:\nX value\na value\n");
        return EXIT_FAILURE;
    }

    fprintf(stdout, "%20.7f\n", var11(strtod(argv[1], &eptr), strtod(argv[2], &eptr)));

    return 0;
}
