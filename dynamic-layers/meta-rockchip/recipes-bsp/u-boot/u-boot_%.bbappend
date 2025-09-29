FILESEXTRAPATHS:prepend := "${THISDIR}/files:"


python __anonymous () {
    SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master \
        "

    m = d.getVar("MACHINE")
    if m == "scb600" or m == "scb605":
        d.appendVar('SRC_URI', ' file://0001-picocom-add-dts-and-config-for-scb600-and-scb605.patch')
}


SRCREV = "7a4f3c5652157cbb3d26a7728bfe537ea483efc9"
DEPENDS:append = " gnutls-native"

ERROR_QA:remove = "patch-status"