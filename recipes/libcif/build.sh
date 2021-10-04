#!/bin/bash
set -xe

mkdir build
cd build
cmake ..
cmake --build . --config Release
ctest -C Release
cmake --install .
