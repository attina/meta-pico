FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

python __anonymous () {
    m = d.getVar("MACHINE")
    if m == "scb600" or m == "scb605":
        d.appendVar('SRC_URI', ' file://0001-picocom-add-dts-and-config-for-scb600-and-scb605.patch')
}

DEPENDS:append = " gnutls-native"

ERROR_QA:remove = "patch-status"