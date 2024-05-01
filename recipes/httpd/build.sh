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

echo "Building apr-util"
cd apr-util
./configure --prefix=${PREFIX} --with-apr=${PREFIX} --with-expat=${PREFIX} --with-openssl=${PREFIX}
make -j ${CORES}
make install
cd ..
echo

echo "Building httpd"
cd httpd
./configure \
  --prefix=${PREFIX} \
  --with-ssl=${PREFIX} \
  --with-apr=${PREFIX} \
  --with-apr-util=${PREFIX} \
  --enable-http2 \
  --with-nghttp2=${PREFIX}
make -j ${CORES}
make install
cd ..
echo

echo "Building wsgi"
unset CPPFLAGS
cd wsgi
./configure --prefix=${PREFIX} --with-apxs=${PREFIX}/bin/apxs --with-python=${PREFIX}/bin/python3
make -j ${CORES}
make install
cd ..
echo

mv ${PREFIX}/conf ${PREFIX}/conf.orig

rm -fr ${PREFIX}/build
rm -fr ${PREFIX}/build-1
