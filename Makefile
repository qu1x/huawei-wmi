PKG := huawei-wmi
VER := 0.1.0
SRC := $(PKG)-$(VER)/
DSC := $(PKG)_$(VER).dsc
DEB := $(PKG)_$(VER)_all.deb

.PHONY: all
all:
	cd $(SRC) && dpkg-buildpackage --no-sign
	lintian $(DSC)
	lintian $(DEB)

.PHONY: install
install: all
	dpkg -i $(DEB)

.PHONY: uninstall
install:
	dpkg -r $(PKG)

.PHONY: reconfigure
reconfigure:
	dpkg-reconfigure $(DEB)

Makefile:;
