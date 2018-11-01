# PNG
PNG_VERSION := 1.6.35
#PNG_URL := $(SF)/libpng/libpng16/older-releases/$(PNG_VERSION)/libpng-$(PNG_VERSION).tar.xz
PNG_URL := https://nchc.dl.sourceforge.net/project/libpng/libpng16/$(PNG_VERSION)/libpng-$(PNG_VERSION).tar.xz

$(TARBALLS)/libpng-$(PNG_VERSION).tar.xz:
	$(call download,$(PNG_URL))

.sum-png: libpng-$(PNG_VERSION).tar.xz


png: libpng-$(PNG_VERSION).tar.xz .sum-png
	$(UNPACK)
	echo "-----------------appling patch"
	$(APPLY) $(SRC)/png/bins.patch
	$(MOVE)

DEPS_png = zlib $(DEPS_zlib)

.png: png
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && rm -f aclocal.m4
	cd $< && aclocal && autoconf
	cd $< && $(HOSTVARS) $(MAKE) install
	touch $@
