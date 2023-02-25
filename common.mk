DEF := /etc/default/huawei-wmi/
WMI := /sys/devices/platform/huawei-wmi/

CCT := charge*_thresholds
FLS := fn_lock_state

PKG := huawei-wmi
VER := 1.2.0
SRC := $(PKG)-$(VER)/

.DEFAULT_GOAL := all

.PHONY: off
off:
	@echo 0 100 | tee $(DEF)$(CCT) $(WMI)$(CCT)

.PHONY: travel
travel:
	@echo 95 100 | tee $(DEF)$(CCT) $(WMI)$(CCT)

.PHONY: office
office:
	@echo 70 90 | tee $(DEF)$(CCT) $(WMI)$(CCT)

.PHONY: home
home:
	@echo 40 70 | tee $(DEF)$(CCT) $(WMI)$(CCT)

.PHONY: lock
lock:
	@echo 0 | tee $(WMI)$(FLS)

.PHONY: unlock
unlock:
	@echo 1 | tee $(WMI)$(FLS)
