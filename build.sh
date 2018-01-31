#!/bin/bash
export CPPFLAGS="-fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CXXFLAGS="-fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 -frtti -fexceptions "
export CFLAGS="  -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
wget https://openssl.org/source/openssl-1.0.2g.tar.gz && \
tar xvf openssl-1.0.2g.tar.gz && \
cd openssl-1.0.2g && \
./Configure android --prefix=/home/dev/out no-shared no-idea no-mdc2 no-rc5 no-zlib no-zlib-dynamic no-bf no-cast no-seed no-md2 enable-tlsext no-ssl2 no-ssl3 enable-ec enable-ecdh enable-ecp && \
make depend && \
make && \
sudo make install_sw && \
cd /home/dev && \
rm openssl-1.0.2g.tar.gz && \
rm -rf openssl-1.0.2g