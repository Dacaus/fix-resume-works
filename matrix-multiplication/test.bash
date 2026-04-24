#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
USE_PERF=false


# i-j-k 版本
clang++ -O2 -g "$PROJECT_ROOT/matrix-multiplication/matmul_ijk.cpp" -o "$SCRIPT_DIR/matmul_ijk"
time "$PROJECT_ROOT/matrix-multiplication/matmul_ijk"


# i-k-j 版本
clang++ -O2 -g "$PROJECT_ROOT/matrix-multiplication/matmul_ikj.cpp" -o "$SCRIPT_DIR/matmul_ikj"
time "$PROJECT_ROOT/matrix-multiplication/matmul_ikj"