#!/bin/bash
set -xe

# temporary
cd modules
git clone https://gitlab.com/cctbx/uc_metrics.git
git clone https://github.com/yayahjb/ncdist.git
cd uc_metrics
git lfs install --local
git lfs pull
cd ../..
# temporary

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

# change libann to libann_cctbx
cd modules/cctbx_project/xfel
${PYTHON} ${RECIPE_DIR}/fix_annlib.py
cd ../../..

# configure
export CCTBX_SKIP_CHEMDATA_CACHE_REBUILD=1
mkdir build
cd build
libtbx.configure xfel uc_metrics

# fix SConstruct
${PYTHON} ${RECIPE_DIR}/fix_sconstruct.py

# build
libtbx.scons -j ${CPU_COUNT}
