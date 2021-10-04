#!/bin/bash
set -xe

mkdir build
cd build
cmake -DBUILD_SHARED_LIBS=ON ..
cmake --build . --config Release
ctest -C Release
cmake --install .
