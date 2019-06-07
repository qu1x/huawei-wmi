PKG := huawei-wmi
VER := 0.1.0
SRC := $(PKG)-$(VER)/
DSC := $(PKG)_$(VER).dsc
DEB := $(PKG)_$(VER)_all.deb

.PHONY: all
all: $(DEB)

.PHONY: install
install: $(DEB)
	dpkg --install $(DEB)

.PHONY: remove
remove:
	dpkg --remove $(PKG)

.PHONY: purge
purge:
	dpkg --purge $(PKG)

.PHONY: reconfigure
reconfigure:
	dpkg-reconfigure $(PKG)

.PHONY: clean
clean:
	cd $(SRC) && dpkg-buildpackage --no-sign --post-clean

.PHONY: distclean
distclean: clean
	rm --force *.deb
	rm --force *.buildinfo
	rm --force *.changes
	rm --force *.dsc
	rm --force *.xz

.PHONY: translate
translate:
	cd $(SRC) && debconf-updatepo

$(DEB): $(shell find $(SRC) | grep -vFf .gitignore)
	cd $(SRC) && dpkg-buildpackage --no-sign
	touch $@
	lintian $(DSC)
	lintian $(DEB)

Makefile:;
