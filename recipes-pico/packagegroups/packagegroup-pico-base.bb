# Copyright (C) 2024 Picocom
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Picocom group for development tools"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"
inherit packagegroup

PACKAGES = "${PN}"

RDEPENDS:${PN} = " \
    pciutils \
"