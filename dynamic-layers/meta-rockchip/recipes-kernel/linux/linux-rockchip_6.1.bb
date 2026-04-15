# Copyright (C) 2025 Picocom Chips
# Released under the MIT license (see COPYING.MIT for the terms)
# Author: Gavin Gao <attinagaoxu@gmail.com>

SUMMARY = "Linux Kernel for Rockchip SoCs"
SECTION = "kernel"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

require linux-rockchip.inc

# --- OK3576 Kernel Configuration ---
LINUX_VERSION:ok3576 = "6.1"
KBUILD_DEFCONFIG:ok3576 = "OK3576-C-linux_defconfig"

# Ensure this matches your MACHINE name in local.conf
COMPATIBLE_MACHINE = "ok3576"

