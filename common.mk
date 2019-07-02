# Copyright (c) 2019 Rouven Spreckels <n3vu0r@qu1x.org>
#
# Usage of the works is permitted provided that
# this instrument is retained with the works, so that
# any entity that uses the works is notified of this instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

ETC := /etc/default/huawei-wmi/
SYS := /sys/devices/platform/huawei-wmi/

PKG := huawei-wmi
VER := 0.1.0
SRC := $(PKG)-$(VER)/

.DEFAULT_GOAL := all

.PHONY: off
off:
	@echo 0 100 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: travel
travel:
	@echo 95 100 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: office
office:
	@echo 70 90 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: home
home:
	@echo 40 70 | tee $(ETC)charge_thresholds $(SYS)charge_thresholds

.PHONY: lock
lock:
	@echo 0 | tee $(SYS)fn_lock_state

.PHONY: unlock
unlock:
	@echo 1 | tee $(SYS)fn_lock_state
