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
${PYTHON} bootstrap.py build \
  --builder=xfel \
  --use-conda ${PREFIX} \
  --nproc ${CPU_COUNT} \
  --config-flags="--compiler=conda" \
  --config-flags="--use_environment_flags" \
  --config-flags="--no_bin_python" \
  --config-flags="--skip_phenix_dispatchers"
