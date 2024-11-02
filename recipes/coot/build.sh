#!/bin/bash

CORES=4

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
