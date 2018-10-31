#!/bin/bash -x

src=android/ssl
dst=~/Github/cocos2d-x-lite/external/android

for arch in armeabi-v7a arm64-v8a x86 ; 
do 
	cp -rv $src/prebuilt/$arch/*.a $dst/$arch/
	cp -v  $src/include/openssl    $dst/$arch/incllude/
done
