PKG := huawei-wmi
VER := 0.1.0
SRC := $(PKG)-$(VER)/
DSC := $(PKG)_$(VER).dsc
DEB := $(PKG)_$(VER)_all.deb

.PHONY: all
all: $(DEB)

.PHONY: install
install: $(DEB)
	dpkg -i $(DEB)

.PHONY: uninstall
uninstall:
	dpkg -r $(PKG)

.PHONY: reconfigure
reconfigure:
	dpkg-reconfigure $(PKG)

.PHONY: clean
clean:
	cd $(SRC) && dpkg-buildpackage --post-clean
	rm --force *.deb
	rm --force *.buildinfo
	rm --force *.changes
	rm --force *.dsc
	rm --force *.xz

$(DEB):
	cd $(SRC) && dpkg-buildpackage --no-sign
	lintian $(DSC)
	lintian $(DEB)

Makefile:;
