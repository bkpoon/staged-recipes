#!/bin/bash

CORES=4

echo "Building apr"
cd apr
touch libtoolT
./configure --prefix=${PREFIX}
make -j ${CORES}
make install
cd ..
echo

ls ${PREFIX}/include

echo "Building apr-util"
cd apr-util
./configure --prefix=${PREFIX} --with-apr=${PREFIX} --with-expat=${PREFIX} --with-openssl=${PREFIX}
make -j ${CORES}
make install
cd ..
echo

echo "Building httpd"
cd httpd
./configure --prefix=${PREFIX} --with-ssl=${PREFIX} --with-apr=${PREFIX} --with-apr-util=${PREFIX}
make -j ${CORES}
make install
cd ..
echo

echo "Building ${WSGI}"
cd wsgi
./configure --prefix=${PREFIX} --with-apxs=${PREFIX}/bin/apxs --with-python=${PREFIX}/bin/python3
make -j ${CORES}
make install
cd ..
echo
