# recipe for picocom pc802 pcie kernel driver and test program
# Gavin Gao <attinagaoxu@gmail.com>

LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "git://git@world-attina/pico/pc802_pcie_driver.git;protocol=ssh;branch=master"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "18b8cbb130fce0d55f7274ceea4cd10c87cbba96"

S = "${WORKDIR}/git"
