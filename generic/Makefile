# Copyright (c) 2019 Rouven Spreckels <n3vu0r@qu1x.org>
#
# Usage of the works is permitted provided that
# this instrument is retained with the works, so that
# any entity that uses the works is notified of this instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

include ../common.mk

SRC := huawei-wmi-0.1.0/

UDEV := /lib/udev/rules.d/
SYSTEMD := /lib/systemd/system/

SHELL := /bin/sh

.PHONY: all
all:

.PHONY: install
install: users
	groupadd --system huawei-wmi 2> /dev/null || true
	for user in $$(cat $<); do \
		usermod --append --groups huawei-wmi "$$user"; \
	done
	install -d $(ETC)
	install $(SRC)README.md $(ETC)
	chmod g+s $(ETC)
	chgrp huawei-wmi $(ETC)
	[ -e $(ETC)/charge_thresholds ] || { \
		cat $(SYS)/charge_thresholds 2> /dev/null || echo 0 100; \
	} > $(ETC)/charge_thresholds
	chmod g=u $(ETC)charge_thresholds
	install $(SRC)10-huawei-wmi.rules $(UDEV)
	install $(SRC)huawei-wmi-privilege.service $(SYSTEMD)
	install $(SRC)huawei-wmi-reinstate.service $(SYSTEMD)
	systemctl daemon-reload
	systemctl enable huawei-wmi-privilege huawei-wmi-reinstate
	udevadm control --reload-rules && udevadm trigger --action=add || true

.PHONY: reconfigure
reconfigure: clean install

users:
	@echo "Please list the users who are allowed to change WMI settings, such"
	@echo "as the battery charge-thresholds and the Fn-lock state. You probably"
	@echo "want to to list your desktop users."
	@echo
	@read -p "List of users separated by space: " users; echo "$$users" > $@

.PHONY: remove
remove:
	systemctl disable huawei-wmi-reinstate huawei-wmi-privilege || true
	rm --force $(ETC)README.md
	rm --force $(ETC)charge_thresholds
	rmdir $(ETC) || true
	rm --force $(UDEV)10-huawei-wmi.rules
	rm --force $(SYSTEMD)huawei-wmi-privilege.service
	rm --force $(SYSTEMD)huawei-wmi-reinstate.service
	groupdel huawei-wmi || true

.PHONY: clean
clean:
	@rm --force users

Makefile:;
