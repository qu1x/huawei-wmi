# Copyright (c) 2019 Rouven Spreckels <n3vu0r@qu1x.org>
#
# Usage of the works is permitted provided that
# this instrument is retained with the works, so that
# any entity that uses the works is notified of this instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

include ../common.mk

GEN := ../generic/$(SRC)
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
	rm --force $(CPY)
	rm --force *.deb
	rm --force *.buildinfo
	rm --force *.changes
	rm --force *.dsc
	rm --force *.xz

.PHONY: translate
translate:
	cd $(SRC) && debconf-updatepo

CPY := $(SRC)10-huawei-wmi.rules
CPY += $(SRC)debian/huawei-wmi-privilege.service
CPY += $(SRC)debian/huawei-wmi-reinstate.service
CPY += $(SRC)available
CPY += $(SRC)privilege
CPY += $(SRC)reinstate

$(DEB): $(CPY) $(shell find $(SRC) | grep -vFf .gitignore)
	cd $(SRC) && dpkg-buildpackage --no-sign
	touch $@
	lintian $(DSC)
	lintian $(DEB)

$(SRC)10-huawei-wmi.rules: $(GEN)10-huawei-wmi.rules
	cp --archive $< $@

$(SRC)debian/huawei-wmi-privilege.service: $(GEN)huawei-wmi-privilege.service
	cp --archive $< $@

$(SRC)debian/huawei-wmi-reinstate.service: $(GEN)huawei-wmi-reinstate.service
	cp --archive $< $@

$(SRC)available: $(GEN)available
	cp --archive $< $@

$(SRC)privilege: $(GEN)privilege
	cp --archive $< $@

$(SRC)reinstate: $(GEN)reinstate
	cp --archive $< $@

Makefile:;
