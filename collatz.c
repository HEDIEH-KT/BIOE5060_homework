#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: ./collatz number\nPlease provide a positive integer as argument.\n");
        return 1;
    }

    long num = atol(argv[1]);
    if (num <= 0) {
        printf("Please provide a positive integer.\n");
        return 1;
    }

    printf("%ld", num);
    while (num != 1) {
        if (num % 2 == 0) {
            num = num / 2;
        } else {
            num = num * 3 + 1;
        }
        printf(", %ld", num);
    }

    printf("\n");
    return 0;
}
