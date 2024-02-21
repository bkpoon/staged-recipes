#!/bin/bash
set -ex

mkdir -p build
cd build

cmake ${CMAKE_ARGS} ..
make

ls -lrt

mkdir -p ${PREFIX}/bin/
cp probe ${PREFIX}/bin/
