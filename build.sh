#!/bin/bash

OPENSSL_VERSION=1.0.2g

CWD=$PWD
mkdir -p $CWD/build

cd $CWD/build
if [ ! -f openssl-$OPENSSL_VERSION.tar.gz ];then
wget https://openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
fi
if [ -d openssl-$OPENSSL_VERSION.tar.gz ];then
rm -rf openssl-$OPENSSL_VERSION.tar.gz
fi
tar xf openssl-$OPENSSL_VERSION.tar.gz
cd openssl-$OPENSSL_VERSION
./Configure android --prefix=$CWD/build no--shared no-ssl2 no-ssl3 no-hw no-asm no-unit-test
make depend
make
make install_sw
cd $CWD