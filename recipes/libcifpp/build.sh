#!/bin/bash
set -xe

# instructions from https://github.com/PDB-REDO/libcifpp#building
cmake ${CMAKE_ARGS} --trace-expand -S . -B build \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_COMPILER=${CXX}

cmake --build build
cmake --install build

ctest --test-dir build
