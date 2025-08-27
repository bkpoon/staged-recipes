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

# remove intermediate objects in build directory
find . -name "*.o" -type f -delete
cd ..

# remove simtbx
rm -fr ./build/*simtbx*
rm -fr ./build/lib/simtbx*
rm -fr ./modules/cctbx_project/simtbx

# fix rpath on macOS because libraries and extensions will be in different locations
if [[ ! -z "$MACOSX_DEPLOYMENT_TARGET" ]]; then
  echo Fixing rpath:
  ${PYTHON} ${RECIPE_DIR}/fix_macos_rpath.py
fi

# install
CCTBX_CONDA_BUILD=./modules/cctbx_project/libtbx/auto_build/conda_build
./build/bin/libtbx.python ${CCTBX_CONDA_BUILD}/install_build.py --preserve-egg-dir

# remove extra copies of dispatchers
echo Removing some duplicate dispatchers
find ${PREFIX}/bin -name "*show_dist_paths" -not -name "libtbx.show_dist_paths" -type f -delete
find ${PREFIX}/bin -name "*show_build_path" -not -name "libtbx.show_build_path" -type f -delete

# remove extraneous stuff in share
rm -fr ${PREFIX}/cxi_user
rm -fr ${PREFIX}/share/cctbx
rm -fr ${PREFIX}/share/glib-2.0
rm -fr ${PREFIX}/share/icons
