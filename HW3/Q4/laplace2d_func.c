#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "laplace2d_func.h"

// Function to parse command-line arguments
void get_input(grid *grid2d, int argc, char **argv) {
    if (argc < 5) {
        printf("Usage: ./laplace2d Nx Ny tol omega\n");
        exit(1);
    }
    grid2d->Nx = atoi(argv[1]);
    grid2d->Ny = atoi(argv[2]);
    grid2d->tol = atof(argv[3]);
    grid2d->omega = atof(argv[4]);
}

// Function to initialize the domain (allocate memory for the 3D field)
void init_domain(grid *grid2d) {
    int i, j;
    grid2d->field[0] = (double **)malloc(grid2d->Nx * sizeof(double *));
    grid2d->field[1] = (double **)malloc(grid2d->Nx * sizeof(double *));
    for (i = 0; i < grid2d->Nx; i++) {
        grid2d->field[0][i] = (double *)malloc(grid2d->Ny * sizeof(double));
        grid2d->field[1][i] = (double *)malloc(grid2d->Ny * sizeof(double));
        for (j = 0; j < grid2d->Ny; j++) {
            grid2d->field[0][i][j] = 0.0;
            grid2d->field[1][i][j] = 0.0;
        }
    }

    for (j = 0; j < grid2d->Ny; j++) {
        grid2d->field[0][0][j] = 1.0;
        grid2d->field[1][0][j] = 1.0;
    }
}

// Function to update the domain (solve Laplace equation iteratively)
void update_domain(grid *grid2d) {
    int iter = 0, i, j;
    double diff, max_diff;

    do {
        max_diff = 0.0;
        for (i = 1; i < grid2d->Nx - 1; i++) {
            for (j = 1; j < grid2d->Ny - 1; j++) {
                double old_val = grid2d->field[iter % 2][i][j];
                double new_val = (grid2d->field[iter % 2][i+1][j] + grid2d->field[iter % 2][i-1][j] +
                                  grid2d->field[iter % 2][i][j+1] + grid2d->field[iter % 2][i][j-1]) / 4.0;
                grid2d->field[(iter + 1) % 2][i][j] = (1.0 - grid2d->omega) * grid2d->field[(iter + 1) % 2][i][j] + grid2d->omega * new_val;
                diff = fabs(grid2d->field[(iter + 1) % 2][i][j] - old_val);
                if (diff > max_diff) max_diff = diff;
            }
        }
        iter++;
        if (iter % 2 == 0) {
            printf("Iteration %d, max difference: %f\n", iter, max_diff);
        }
    } while (max_diff > grid2d->tol);
}

// Function to free allocated memory
void free_domain(grid *grid2d) {
    for (int i = 0; i < grid2d->Nx; i++) {
        free(grid2d->field[0][i]);
        free(grid2d->field[1][i]);
    }
    free(grid2d->field[0]);
    free(grid2d->field[1]);
}

