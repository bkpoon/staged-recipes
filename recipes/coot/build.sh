#!/bin/bash

CORES=4

echo "Building dependencies"
echo "====================="
echo

# fftw
echo "Building fftw"
cd fftw
./configure --prefix=${PREFIX} --enable-shared --enable-float
make -j ${CORES}
make install
cd ..
echo

# mmdb2
echo "Building mmdb2"
cd mmdb2
./configure --prefix=${PREFIX} --enable-shared --disable-static
make -j ${CORES}
make install
cd ..
echo

# ssm
echo "Building ssm"
cd ssm
./configure --prefix=${PREFIX} --enable-shared --disable-static
make -j ${CORES}
make install
cd ..
echo

# libccp4
echo "Building libccp4"
cd libccp4
./configure --prefix=${PREFIX} --enable-shared --disable-static --disable-fortran
make -j ${CORES}
make install
cd ..
echo

# clipper
echo "Building clipper"
cd clipper
./configure \
  --prefix=${PREFIX} \
	--enable-mmdb=${PREFIX} \
	--enable-ccp4=${PREFIX} \
	--enable-shared  \
	--enable-mmdb    \
	--enable-cif     \
	--enable-ccp4    \
	--enable-minimol \
	--enable-cns
make -j ${CORES}
make install
cd ..
echo

# coot
echo "Building coot"
echo "============="
echo

cd coot

# automake (from build-it-3-3)
rm -rf autom4te.cache
if [ -e ltmain.sh    ] ; then rm ltmain.sh    ; fi
if [ -e config.guess ] ; then rm config.guess ; fi
if [ -e config.sub   ] ; then rm config.sub   ; fi
./autogen.sh

export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig

./configure \
  --prefix=${PREFIX} \
  --with-fftw-prefix=${PREFIX} \
  SHELL=/bin/bash \
  PYTHON=python3 \
  COOT_BUILD_INFO_STRING="$coot_build_info_string" \
  --with-boost=${PREFIX}  \
  --with-boost-libdir=${PREFIX}/lib  \
  --with-enhanced-ligand-tools \
  --with-rdkit-prefix=${PREFIX} \
  --with-guile \
  --disable-static \
  --with-glib-prefix=${PREFIX} \
  --with-gtk-prefix==${PREFIX} \
  --with-sysroot=${PREFIX}
make -j ${CORES}
make install
cd ..
echo
