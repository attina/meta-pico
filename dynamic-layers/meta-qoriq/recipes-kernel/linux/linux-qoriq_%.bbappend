FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

python __anonymous () {
    pv = d.getVar('PV')
    if pv.startswith("6.12"):
        d.appendVar('SRC_URI', ' file://patch-6.12.28-rt10.patch')
        d.appendVar('SRC_URI', ' file://0001-picocom-ls1046apscb-patch-for-linux-6.12.patch')
        d.appendVar('SRC_URI', ' file://0002-ls1046apscbc-add-device-tree-for-linux-6.12.patch')
        d.appendVar('SRC_URI', ' file://0003-ls1046apxcp-add-device-tree-for-linux-6.12.patch')
        d.appendVar('SRC_URI', ' file://0005-ls1046apxcp-add-dts-file-for-cscn-for-linux-6.12.patch')
        d.appendVar('SRC_URI', ' file://0006-ls1046apscbx5-add-dts-file-for-cscn-for-linux-6.12.patch')
    elif pv.startswith("6.6"):
        d.appendVar('SRC_URI', ' file://patch-6.6.52-rt43.patch')
        d.appendVar('SRC_URI', ' file://0001-picocom-ls1046apscb-patch-for-linux-6.6.patch')
        d.appendVar('SRC_URI', ' file://0002-ls1046apscbc-add-device-tree-for-linux-6.6.patch')
        d.appendVar('SRC_URI', ' file://0004-ls1046apxcp-add-device-tree-for-linux-6.6.patch')
        d.appendVar('SRC_URI', ' file://0007-ls1046apxcp-add-dts-file-for-cscn-for-linux-6.6.patch')
        d.appendVar('SRC_URI', ' file://0008-ls1046apscbx5-add-dts-file-for-linux-6.6.patch')
    elif pv.startswith("5.10"):
        d.appendVar('SRC_URI', ' file://0001-picocom-apply-patches-for-ls1046apscb-board.patch')
    else:
        raise bb.parse.SkipRecipe("Unsupported version %s" % pv)
}

SRC_URI += " file://ls1046apscb.cfg \
        "

DELTA_KERNEL_DEFCONFIG += "ls1046apscb.cfg"