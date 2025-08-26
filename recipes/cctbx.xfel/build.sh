#!/bin/bash
set -xe

# Use -O3 optimization
export CFLAGS="${CFLAGS} -O3"
export CXXFLAGS="${CXXFLAGS} -O3"

# link bootstrap.py
ln -s modules/cctbx_project/libtbx/auto_build/bootstrap.py

# remove extra source code
rm -fr ./modules/boost
rm -fr ./modules/eigen
rm -fr ./modules/scons

# remove some libtbx_refresh.py files
rm -fr ./modules/dxtbx/libtbx_refresh.py

# build
export CCTBX_SKIP_CHEMDATA_CACHE_REBUILD=1
mkdir build
cd build
libtbx.configure xfel
libtbx.scons ${CPU_COUNT}
