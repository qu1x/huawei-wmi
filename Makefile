ETC := /etc/default/huawei-wmi/
SYS := /sys/devices/platform/huawei-wmi/

UDEV := /lib/udev/rules.d/
SYSTEMD := /lib/systemd/system/

.PHONY: all
all:

.PHONY: install
install:
	groupadd --system huawei-wmi || true
	mkdir --parents --mode=02775 $(ETC)
	chgrp huawei-wmi $(ETC)
	{ cat $(SYS)charge_thresholds || echo 0 100; } > $(ETC)charge_thresholds
	chmod g=u $(ETC)charge_thresholds
	install 10-huawei-wmi.rules $(UDEV)
	install huawei-wmi-privilege.service $(SYSTEMD)
	install huawei-wmi-reinstate.service $(SYSTEMD)
	systemctl daemon-reload
	systemctl enable huawei-wmi-privilege huawei-wmi-reinstate
	udevadm control --reload-rules
	udevadm trigger --action=add

.PHONY: uninstall
uninstall:
	systemctl disable huawei-wmi-reinstate huawei-wmi-privilege || true
	rm --force $(UDEV)10-huawei-wmi.rules
	rm --force $(SYSTEMD)huawei-wmi-privilege.service
	rm --force $(SYSTEMD)huawei-wmi-reinstate.service
	rm --force $(ETC)charge_thresholds
	rmdir $(ETC) || true
	groupdel huawei-wmi || true

.PHONY: off
off:
	echo 0 100 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: travel
travel:
	echo 95 100 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: office
office:
	echo 70 90 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: home
home:
	echo 40 70 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: lock
lock:
	echo 0 | tee $(SYS)fn_lock_state

.PHONY: unlock
unlock:
	echo 1 | tee $(SYS)fn_lock_state

Makefile:;
