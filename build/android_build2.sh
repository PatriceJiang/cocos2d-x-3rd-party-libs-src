#!/bin/sh -x
A_TOOLCHAIN=/Users/cocos/Github/cocos2d-x-3rd-party-libs-src/build/android-toolchain

TOOLCHAIN=$ANDROID_NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin
ARG_SSL_ARCH=android-arm64
ARG_INSTALL_DIR=arm64-v8a
HOST_ARG=aarch64-linux-android

#TOOLCHAIN=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin
#ARG_SSL_ARCH=android-arm
#ARG_INSTALL_DIR=armeabi-v7a
#HOST_ARG=arm-linux-androideabi

#TOOLCHAIN=$ANDROID_NDK/toolchains/x86-4.9/prebuilt/darwin-x86_64/bin
#--TOOLCHAIN=$A_TOOLCHAIN-x86/bin
#ARG_SSL_ARCH=android-x86
#ARG_INSTALL_DIR=x86
#HOST_ARG=i686-linux-android

PATH="$TOOLCHAIN:$PATH"
#CC=clang
#RANLIB=$HOST_ARG-ranlib
#AR="${HOST_ARG}-ar"

INSTALL_PREFIX=/Users/cocos/Github/cocos2d-x-3rd-party-libs-src/contrib/install-android/$ARG_INSTALL_DIR 
COPY_DEST=/Users/cocos/Github/cocos2d-x-3rd-party-libs-src/build/android/ssl
BIN_DEST=/Users/cocos/Github/cocos2d-x-3rd-party-libs-bin/openssl/prebuilt/android/

export PATH
export CFLAGS
export CC
#export RANLIB
#export AR

#make clean

echo `which clang`

./Configure $ARG_SSL_ARCH --prefix=$INSTALL_PREFIX no-shared no-unit-test no-tests no-stdio  -D__ANDROID_API__=14

#sed -i "" 's/CC=$(CROSS_COMPILE\)gcc/CC=clang/g' Makefile
#sed -i "" 's/CXX=$(CROSS_COMPILE)g++/CXX=clang++/g' Makefile
#sed -i "" 's/ARFLAGS= r/ARFLAGS= rs/g' Makefile

make -j 8
make install -j 4 > /dev/null
mkdir -p $COPY_DEST/prebuilt/$ARG_INSTALL_DIR
mkdir -p $COPY_DEST/include
cp $INSTALL_PREFIX/lib/*.a $COPY_DEST/prebuilt/$ARG_INSTALL_DIR/
cp -r $INSTALL_PREFIX/include $COPY_DEST

cp -r $COPY_DEST/prebuilt/* /Users/cocos/Github/cocos2d-x-3rd-party-libs-bin/openssl/prebuilt/android/
