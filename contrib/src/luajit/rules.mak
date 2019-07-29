# luajit

LUAJIT_VERSION := 2.1.0-beta3
#LUAJIT_URL := http://luajit.org/download/LuaJIT-$(LUAJIT_VERSION).tar.gz

LUAJIT_GITHUB := https://github.com/luajit/luajit


$(TARBALLS)/LuaJIT-$(LUAJIT_VERSION).tar.xz:
	$(call download_git,$(LUAJIT_GITHUB), v2.1, f0e865dd48)



luajit: LuaJIT-$(LUAJIT_VERSION).tar.xz
	$(UNPACK)
	$(APPLY) $(SRC)/luajit/luajit-v2.1.0-beta3.patch
	$(MOVE)


ifdef HAVE_ANDROID

ifeq ($(MY_TARGET_ARCH),armeabi)
LUAJIT_HOST_CC="/usr/bin/gcc -m32 $(OPTIM)"
endif

ifeq ($(MY_TARGET_ARCH),armeabi-v7a)
LUAJIT_HOST_CC="/usr/bin/gcc -m32 $(OPTIM)"
endif

ifeq ($(MY_TARGET_ARCH),arm64-v8a)
LUAJIT_HOST_CC="/usr/bin/gcc -m64 $(OPTIM)"
endif

ifeq ($(MY_TARGET_ARCH),x86)
LUAJIT_HOST_CC="/usr/bin/gcc -m32 $(OPTIM)"
endif

ifeq ($(MY_TARGET_ARCH),x86_64)
LUAJIT_HOST_CC="/usr/bin/gcc -m64 $(OPTIM) -DLUAJIT_ENABLE_GC64"
endif

LUAJIT_TARGET_FLAGS="${EXTRA_CFLAGS} ${EXTRA_LDFLAGS}"
LUAJIT_CROSS_HOST=$(HOST)-
endif # end hav android

.luajit: luajit
ifdef HAVE_ANDROID
	cd $< && $(MAKE) HOST_CC=$(LUAJIT_HOST_CC) CROSS=$(LUAJIT_CROSS_HOST) CC=clang TARGET_SYS=Linux TARGET_FLAGS=$(LUAJIT_TARGET_FLAGS)  
endif

	cd $< && $(MAKE) install PREFIX=$(PREFIX)
	touch $@
