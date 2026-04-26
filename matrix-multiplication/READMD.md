# 矩阵乘法循环顺序对性能的影响

本实验通过两个 C 程序对比矩阵乘法中不同循环顺序的性能差异，展示了**内存访问模式与缓存局部性**对 CPU 密集型任务的巨大影响。

## 文件说明

- `matmul_ijk.cpp` —— 使用 `i-j-k` 循环顺序的矩阵乘法
- `matmul_ikj.cpp` —— 使用 `i-k-j` 循环顺序的矩阵乘法
- `benchmark_20260426_080946.txt` —— 运行结果与 `perf stat` 性能计数器输出
- `benchmark_20260426_082455.txt` —— 禁用自动向量化与循环展开后的对比结果

## 实验环境与方法

- **矩阵大小**：1024 × 1024（`double` 类型，矩阵总大小约 8 MB × 3）
- **乘法形式**：  
  `C[i][j] += A[i][k] * B[k][j]`
- **编译器**：Clang，基础优化级别 `-O2`；为确保纯粹对比缓存效应，后续测试添加了 `-fno-vectorize -fno-unroll-loops -fno-slp-vectorize` 以禁用自动向量化和循环展开
- **时间测量**：`clock()` 函数
- **性能计数器**：`perf stat` 采集 cache-references、cache-misses、instructions、cycles 等

## 编译与运行

```bash
# 默认优化版本（可能存在向量化/展开）
clang++ -O2 matmul_ijk.cpp -o matmul_ijk
clang++ -O2 matmul_ikj.cpp -o matmul_ikj

# 禁用向量化与展开的版本（用于纯粹观察缓存效应）
clang++ -O2 -fno-vectorize -fno-unroll-loops -fno-slp-vectorize \
    matmul_ijk.cpp -o matmul_ijk_novec
clang++ -O2 -fno-vectorize -fno-unroll-loops -fno-slp-vectorize \
    matmul_ikj.cpp -o matmul_ikj_novec

# 运行并查看 CPU 性能计数器
perf stat ./matmul_ijk
perf stat ./matmul_ikj