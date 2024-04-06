FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-ls1046apscb-initial-firmware-for-ddr-add-more.patch"

RCW_FOLDER:ls1046apscb = "ls1046apscb"

RCW_SUFFIX:ls1046a = "${@bb.utils.contains('DISTRO_FEATURES', 'secure', '_sben.bin', '.bin', d)}"

BOOTTYPE:ls1046apscb = "qspi sd"

