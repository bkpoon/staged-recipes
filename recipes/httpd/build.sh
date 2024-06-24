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
./configure \
  --prefix=${PREFIX} \
  --with-apr=${PREFIX} \
  --with-expat=${PREFIX} \
  --with-openssl=${PREFIX}
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
  --with-nghttp2=${PREFIX} \
  --enable-lua \
  --with-lua=${PREFIX}
make -j ${CORES}
make install
cd ..
echo

echo "Building wsgi"
OLD_CPPFLAGS=${CPPFLAGS}
unset CPPFLAGS
cd wsgi
./configure \
  --prefix=${PREFIX} \
  --with-apxs=${PREFIX}/bin/apxs \
  --with-python=${PREFIX}/bin/python3
make -j ${CORES}
make install
cd ..
CPPFLAGS=${OLD_CPPFLAGS}
echo

echo "Building php"
cd php
find . -type f -name "zend_max_execution_timer.c" -exec sed -i 's/CLOCK_BOOTTIME/CLOCK_MONOTONIC/g' {} +
./configure \
  --prefix=${PREFIX} \
  --with-iconv=${PREFIX} \
  --with-libxml=${PREFIX} \
  --with-apxs2=${PREFIX}/bin/apxs \
  --enable-mbstring \
  --enable-intl
make -j ${CORES}
make install
cd ..
echo

mv ${PREFIX}/conf ${PREFIX}/conf.orig

rm -fr ${PREFIX}/build
rm -fr ${PREFIX}/build-1
