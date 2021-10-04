#!/bin/bash
set -xe

# enable C++17 on macOS
if [[ ! -z "$MACOSX_DEPLOYMENT_TARGET" ]]; then
  CXXFLAGS=`echo $CXXFLAGS | sed 's/c++14/c++17/g'`
fi

mkdir build
cd build
cmake -DBUILD_SHARED_LIBS=ON ..
cmake --build . --config Release
ctest -C Release
cmake --install .
