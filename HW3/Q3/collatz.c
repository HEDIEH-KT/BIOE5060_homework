#include <stdio.h>
#include <stdlib.h>

void collatz(int n) {
    while (n != 1) {
        printf("%d, ", n);
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
    }
    printf("1\n");  // Print the final "1" in the sequence
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: ./collatz num\n");
        return 1;
    }

    int num = atoi(argv[1]);
    if (num <= 0) {
        printf("Please enter a positive integer.\n");
        return 1;
    }

    collatz(num);
    return 0;
}

