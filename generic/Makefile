include ../common.mk

UDEV := /lib/udev/rules.d/
SYSTEMD := /lib/systemd/system/
LIB := /usr/lib/huawei-wmi/

SHELL := /bin/sh

.PHONY: all
all:

.PHONY: install
install: users
	groupadd --system huawei-wmi 2> /dev/null || true
	for user in $$(cat $<); do \
		usermod --append --groups huawei-wmi -- "$$user"; \
	done
	install -d $(DEF)
	chmod g+s $(DEF)
	chgrp huawei-wmi $(DEF)
	install -m 644 $(SRC)10-huawei-wmi.rules $(UDEV)
	install -m 644 $(SRC)huawei-wmi-privilege.service $(SYSTEMD)
	install -m 644 $(SRC)huawei-wmi-reinstate.service $(SYSTEMD)
	install -d $(LIB)
	install $(SRC)available $(LIB)
	install $(SRC)privilege $(LIB)
	install $(SRC)reinstate $(LIB)
	systemctl daemon-reload
	systemctl unmask huawei-wmi-privilege huawei-wmi-reinstate
	systemctl enable huawei-wmi-reinstate
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
	systemctl disable huawei-wmi-reinstate || true
	rm --force $(DEF)$(CCT)
	rmdir $(DEF) || true
	rm --force $(UDEV)10-huawei-wmi.rules
	rm --force $(SYSTEMD)huawei-wmi-privilege.service
	rm --force $(SYSTEMD)huawei-wmi-reinstate.service
	rm --force $(LIB)available
	rm --force $(LIB)privilege
	rm --force $(LIB)reinstate
	rmdir $(LIB) || true
	groupdel huawei-wmi || true

.PHONY: clean
clean:
	@rm --force users

Makefile:;
