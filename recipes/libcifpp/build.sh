#!/bin/bash
set -xe

# enable C++17 on macOS
if [[ ! -z "$MACOSX_DEPLOYMENT_TARGET" ]]; then
  CXXFLAGS=`echo $CXXFLAGS | sed 's/c++14/c++17/g'`
fi

# instructions from https://github.com/PDB-REDO/libcifpp#building
# - use conda cmake_args
# - enable shared libraries
mkdir build
cd build
cmake ${CMAKE_ARGS} -DBUILD_SHARED_LIBS=ON ..
cmake --build . --config Release
ctest -C Release
cmake --install .
