#!/bin/bash -x

src=android/ssl
#dst=~/Github/cocos2d-x-lite/external/android
dst=~/tmp/websockets

for arch in armeabi-v7a arm64-v8a x86 ; 
do 
	mkdir -p $dst/$arch
	mkdir -p $dst/$arch/include
	cp -rv $src/prebuilt/$arch/*.a $dst/$arch/
	cp -r  $src/include/openssl    $dst/$arch/include/
done
