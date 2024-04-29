# recipe for picocom pc802 pcie kernel driver and test program
# Gavin Gao <attinagaoxu@gmail.com>
SUMMARY = "PCI-e Driver for Picocom PC802 chip"
HOMEPAGE = "https://www.picocom.com"
MAINTAINER = "Gavin Gao <attinagaoxu@gmail.com>"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

BRANCH = "NDF-190-init-deinit"
SRC_URI = "git://git@gitlab.attina.io/pico/pc802_pcie_driver.git;protocol=ssh;branch=${BRANCH}"

# Modify these as desired
PV = "2.5.3+git${SRCPV}"
SRCREV = "9085fe7572086aeb6c25a4e1b750b175767912da"

S = "${WORKDIR}/git"
