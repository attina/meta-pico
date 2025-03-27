FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master \
    file://0001-picocom-add-dts-and-config-for-scb600-and-scb605.patch \
    "

SRCREV = "6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72"
DEPENDS:append = " gnutls-native"

ERROR_QA:remove = "patch-status"