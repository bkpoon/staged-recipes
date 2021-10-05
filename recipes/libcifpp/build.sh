#!/bin/bash
set -xe

# instructions from https://github.com/PDB-REDO/libcifpp#building
# - use conda cmake_args
# - enable C++17 on macOS
# - link libc++fs on macOS
# - enable shared libraries
mkdir build
cd build
# if [[ ! -z "$MACOSX_DEPLOYMENT_TARGET" ]]; then
#   CXXFLAGS=`echo $CXXFLAGS | sed 's/c++14/c++17/'`
#   cmake ${CMAKE_ARGS} -DCXX_FILESYSTEM_NO_LINK_NEEDED=FALSE -DBUILD_SHARED_LIBS=ON ..
# else
#   cmake ${CMAKE_ARGS} -DBUILD_SHARED_LIBS=ON ..
# fi

if [[ ! -z "$MACOSX_DEPLOYMENT_TARGET" ]]; then
  export MACOSX_DEPLOYMENT_TARGET=10.15
  CMAKE_ARGS=`echo $CMAKE_ARGS | sed 's/OSX_DEPLOYMENT_TARGET=10\.9/OSX_DEPLOYMENT_TARGET=10\.15/'`
  cmake ${CMAKE_ARGS} -DCXX_FILESYSTEM_NO_LINK_NEEDED=TRUE -DBUILD_SHARED_LIBS=ON ..
else
  cmake ${CMAKE_ARGS} -DBUILD_SHARED_LIBS=ON ..
fi

cmake --build . --config Release
ctest -C Release
cmake --install .
