FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-picocom-ls1046apscb-patch-for-linux-6.6.patch \
        file://0003-ls1046apscbc-add-device-tree.patch \
        file://ls1046apscb.cfg \
        "
