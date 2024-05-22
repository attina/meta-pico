# recipe for picocom pc802 pcie kernel driver and test program
# Gavin Gao <attinagaoxu@gmail.com>
SUMMARY = "PCI-e Driver for Picocom PC802 chip"
HOMEPAGE = "https://www.picocom.com"
MAINTAINER = "Gavin Gao <attinagaoxu@gmail.com>"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

FILESEXTRAPATHS:prepend := "${THISDIR}/pc802-firmware:"

BRANCH = "NDF-190-init-deinit"
SRC_URI = " \
    git://git@gitlab.attina.io/pico/pc802_pcie_driver.git;protocol=ssh;branch=${BRANCH} \
	file://pc802.img \
	file://pc802.ssbl \
    "

# Modify these as desired
PV = "2.5.3+git${SRCPV}"
SRCREV = "4320b64b88391227c7c2e7a3129b0a9b583737ac"

S = "${WORKDIR}/git"
