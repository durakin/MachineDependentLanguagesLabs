#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <stdint.h>

long* var11(long, long*, long);

int main()
{
    long n;
    long e;
    long* argArray;
    printf("Enter size of row of array, can't be bigger than 10\n");
    scanf("%ld", &n);
    if (n <= 0 || n  > 10)
    {
        fprintf(stderr, "Size of array is out of [1; 100]!\n");
        return EXIT_FAILURE;
    }
    argArray = (long*) malloc(n * n * sizeof(long));
    printf("Now enter elements of %ldX%ld array, from left to right, from up to above\n", n, n);
    for (int i = 0; i < n*n; i++)
    {
        scanf("%ld", &argArray[i]);
    }
    printf("Now enter number of a row (starting from 0) to apply a task function\n");
    scanf("%ld", &e);
    if (e < 0 || e >= n)
    {
        fprintf(stderr, "Number is out of rows!\n");
        return EXIT_FAILURE;
    }

    long* result = var11(n, argArray, e);
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            printf("%ld ", result[i*3+j]);
        }
        printf("\n");        
    }
    
    return EXIT_SUCCESS;
}
