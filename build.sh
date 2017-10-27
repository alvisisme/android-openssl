#!/bin/bash

set -e
export NDK=/opt/android-ndk

[ ! -f openssl-1.0.2g.tar.gz ] && {
wget https://openssl.org/source/openssl-1.0.2g.tar.gz
}

[ ! -d openssl-1.0.2g ] && {
    tar xvf openssl-1.0.2g.tar.gz
}

# path to NDK
export NDK=/opt/android-ndk

echo $"Choose arch you like to build, arm(1) or arm64(2)? (1/2)"
read ans;

# default
ARCH=arm
TOOLCHAIN_NAME=arm-linux-android-4.9
TOOL_PREFIX=arm-linux-androideabi-

case $ans in
    1)
        ARCH=arm
        TOOLCHAIN_NAME=arm-linux-android-4.9
        TOOL_PREFIX=arm-linux-androideabi-;;
    2)
       	ARCH=arm64
       	TOOLCHAIN_NAME=aarch64-linux-android-4.9
       	TOOL_PREFIX=aarch64-linux-android-;;
    *)
        exit;;
esac

 # create a local android toolchain
$NDK/build/tools/make-standalone-toolchain.sh \
  --force \
  --arch=${ARCH} \
  --platform=android-21 \
  --toolchain=${TOOLCHAIN_NAME} \
  --install-dir=`pwd`/${ARCH}

 # setup environment to use the gcc/ld from the android toolchain
export TOOLCHAIN_PATH=`pwd`/${ARCH}/bin
export NDK_TOOLCHAIN_BASENAME=${TOOLCHAIN_PATH}/${TOOL_PREFIX}
export CC=${NDK_TOOLCHAIN_BASENAME}gcc
export CXX=${NDK_TOOLCHAIN_BASENAME}g++
export LINK=${CXX}
export LD=${NDK_TOOLCHAIN_BASENAME}ld
export AR=${NDK_TOOLCHAIN_BASENAME}ar
export RANLIB=${NDK_TOOLCHAIN_BASENAME}ranlib
export STRIP=${NDK_TOOLCHAIN_BASENAME}strip

# setup buildflags
export ARCH_FLAGS=""
export ARCH_LINK=
export CPPFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CXXFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 -frtti -fexceptions "
export CFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export LDFLAGS=" ${ARCH_LINK} "

echo 'build openssl'
# configure and build openssl
{
PREFIX=$TOOLCHAIN_PATH/..
cd openssl-1.0.2g

case ${ARCH} in
    arm64)
        echo "building arm64 for android"
        ./Configure android --prefix=${PREFIX} no-shared no-idea no-mdc2 no-rc5 no-zlib no-zlib-dynamic no-bf no-cast no-seed no-md2 enable-tlsext no-ssl2 no-ssl3 enable-ec enable-ecdh enable-ecp
        ;;
    arm)
        echo "building arm for android"
       ./Configure android-armv7 --prefix=${PREFIX} no-shared no-idea no-mdc2 no-rc5 no-zlib no-zlib-dynamic no-bf no-cast no-seed no-md2 enable-tlsext no-ssl2 no-ssl3 enable-ec enable-ecdh enable-ecp
       ;;
    *)
        exit;;
esac

PATH=$TOOLCHAIN_PATH:$PATH make depend
PATH=$TOOLCHAIN_PATH:$PATH make
PATH=$TOOLCHAIN_PATH:$PATH make install_sw
cd ..
}
echo 'build openssl done'