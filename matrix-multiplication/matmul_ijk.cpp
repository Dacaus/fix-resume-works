#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1024  // 矩阵大小，可根据内存调小

double A[N][N], B[N][N], C[N][N];

void matmul_ijk() {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            for (int k = 0; k < N; k++)
                C[i][j] += A[i][k] * B[k][j];  
}

int main() {
    //  初始化
    for (int i = 0; i < N; i++){
        for (int j = 0; j < N; j++){
            
            A[i][j] = (double)(i + j) / N;
            B[i][j] = (double)(i - j + N) / N;
            C[i][j] = 0.0;
        }
        }

    clock_t start = clock();
    matmul_ijk();  // 再跑快的版本
    clock_t end = clock();
    printf("i-j-k: %f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);

    printf("C[0][0] = %f (防优化)\n", C[0][0]);
    return 0;
}