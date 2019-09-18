# Copyright (c) 2019 Rouven Spreckels <n3vu0r@qu1x.org>
#
# Usage of the works is permitted provided that
# this instrument is retained with the works, so that
# any entity that uses the works is notified of this instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

DEF := /etc/default/huawei-wmi/
WMI := /sys/devices/platform/huawei-wmi/

CCT := charge*_thresholds
FLS := fn_lock_state

PKG := huawei-wmi
VER := 1.1.0
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
