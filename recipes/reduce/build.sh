#!/bin/bash
set -ex

mkdir -p build
cd build

cmake ${CMAKE_ARGS} ..
make
make install
