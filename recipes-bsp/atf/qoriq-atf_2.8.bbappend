FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-picocom-ls1046apscb-patch-for-atf-2.8.patch"

RCW_FOLDER:ls1046apscb = "ls1046apscb"

RCW_SUFFIX:ls1046a = "${@bb.utils.contains('DISTRO_FEATURES', 'secure', '_sben.bin', '.bin', d)}"

BOOTTYPE:ls1046apscb = "qspi sd"

