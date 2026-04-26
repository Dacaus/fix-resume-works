#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1024  // 矩阵大小，可根据内存调小

double A[N][N], B[N][N], C[N][N];

void matmul_ikj() {
    for (int i = 0; i < N; i++)
        for (int k = 0; k < N; k++)
            for (int j = 0; j < N; j++)
                C[i][j] += A[i][k] * B[k][j];
}

int main() {
    // 初始化
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = (double)(i + j) / N;
            B[i][j] = (double)(i - j + N) / N;
            C[i][j] = 0.0;
        }
    }

    clock_t start = clock();
    matmul_ikj();  // 先跑慢的版本
    clock_t end = clock();
    printf("i-k-j: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);

    return 0;
}