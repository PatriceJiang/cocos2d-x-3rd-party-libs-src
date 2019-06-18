# openal-soft-android

OPENAL_GITURL := https://github.com/PatriceJiang/openal-soft-android

$(TARBALLS)/openal-soft-android-master.zip
	$(call download_git,$(OPENAL_GITURL),master,60e7d26)

.sum-openal: openal-soft-android-master.zip
	$(warning $@ not implemented)
	touch $@

openal: openal-soft-android-master.zip .openal
	$(UNPACK)
	$(MOVE)

ifdef HAVE_TIZEN
EX_ECFLAGS = -fPIC
endif


# DEPS_openal = zlib $(DEPS_zlib)

.openal: openal toolchain.cmake
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS) $(EX_ECFLAGS)" $(CMAKE) -DLWS_WITH_LIBUV=ON -DLWS_WITH_SSL=ON -DLWS_WITH_SHARED=OFF -DLWS_WITHOUT_TEST_SERVER=ON -DLWS_WITHOUT_TEST_SERVER_EXTPOLL=ON -DLWS_WITHOUT_TEST_PING=ON -DLWS_WITHOUT_TEST_ECHO=ON -DLWS_WITHOUT_TEST_CLIENT=ON -DLWS_WITHOUT_TEST_FRAGGLE=ON -DLWS_IPV6=ON $(make_option)
	cd $< && $(MAKE) VERBOSE=1 install
	touch $@
