# MPG123
MPG123_URL := https://downloads.sourceforge.net/project/mpg123/mpg123/1.25.10/mpg123-1.25.10.tar.bz2


$(TARBALLS)/mpg123-1.25.10.tar.bz2
	$(call download,$(PNG_URL))

.mpg123: mpg123-1.25.10.tar.bz2


mpg123: mpg123-1.25.10.tar.bz2 .mpg123
	$(UNPACK)
	$(MOVE)

.mpg123: mpg123
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE) install
	touch $@
