#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
USE_PERF=false
PERF_EVENTS="cache-references,cache-misses,instructions,cycles"
OUTPUT_FILE="${1:-$SCRIPT_DIR/benchmark_$(date +%Y%m%d_%H%M%S).txt}"

# Capture both stdout/stderr to file while still printing to terminal.
exec > >(tee "$OUTPUT_FILE") 2>&1

echo "Output file: $OUTPUT_FILE"
echo "Started at: $(date '+%F %T')"


# i-j-k 版本 关闭循环展开和自动向量化
clang++ -O2 -g -fno-unroll-loops -fno-vectorize -fno-slp-vectorize "$PROJECT_ROOT/matrix-multiplication/matmul_ijk.cpp" -o "$SCRIPT_DIR/matmul_ijk"
time "$PROJECT_ROOT/matrix-multiplication/matmul_ijk"
if command -v perf >/dev/null 2>&1; then
	perf stat -e "$PERF_EVENTS" "$PROJECT_ROOT/matrix-multiplication/matmul_ijk"
fi


# i-k-j 版本 关闭循环展开和自动向量化
clang++ -O2 -g -fno-unroll-loops -fno-vectorize -fno-slp-vectorize "$PROJECT_ROOT/matrix-multiplication/matmul_ikj.cpp" -o "$SCRIPT_DIR/matmul_ikj"
time "$PROJECT_ROOT/matrix-multiplication/matmul_ikj"
if command -v perf >/dev/null 2>&1; then
	perf stat -e "$PERF_EVENTS" "$PROJECT_ROOT/matrix-multiplication/matmul_ikj"
fi

echo "Finished at: $(date '+%F %T')"