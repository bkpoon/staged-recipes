#!/bin/bash
set -xe

# instructions from https://github.com/PDB-REDO/libcifpp#building
cmake ${CMAKE_ARGS} --trace-expand -S . -B build \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DCMAKE_BUILD_TYPE=Release

cmake --build build
cmake --install build

ctest --output-on-failure --test-dir build || true
