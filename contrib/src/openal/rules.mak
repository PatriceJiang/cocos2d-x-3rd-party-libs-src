# openal-soft-android

OPENAL_GITURL := https://github.com/PatriceJiang/openal-soft-android

$(TARBALLS)/openal-soft-android-master.tar.xz:
	$(call download_git,$(OPENAL_GITURL),master,60e7d26)

.sum-openal: openal-soft-android-master.tar.xz
	$(warning $@ not implemented)
	touch $@

openal: openal-soft-android-master.tar.xz .sum-openal
	$(UNPACK)
	$(MOVE)


.openal: openal toolchain.cmake
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS) $(EX_ECFLAGS)" $(CMAKE) -DLIBTYPE=STATIC $(make_option)
	cd $< && $(MAKE) VERBOSE=1 install
	touch $@
