#!/bin/bash

VERSION=1.0.2g
wget https://openssl.org/source/openssl-$VERSION.tar.gz
tar xf openssl-$VERSION.tar.gz
cd openssl-$VERSION
./Configure android --prefix=/home/out no--shared no-ssl2 no-ssl3 no-hw no-asm no-unit-test
make depend
make
make install_sw