FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

python __anonymous () {
    pv = d.getVar('PV')
    if pv.startswith("2025.04"):
        d.appendVar('SRC_URI', ' file://0001-picocom-ls1046apscb-patch-for-uboot-2025.04.patch')
    elif pv.startswith("2024.04"):
        d.appendVar('SRC_URI', ' file://0001-picocom-ls1046apscb-patch-for-uboot-2024.04.patch')
    elif pv.startswith("2023.04"):
        d.appendVar('SRC_URI', ' file://0001-picocom-ls1046apscb-patch-for-uboot-2023.4.patch')
    elif pv.startswith("2021.04"):
        d.appendVar('SRC_URI', ' file://0001-picocom-u-boot-driver-for-ls1046-board.patch')
    else:
        raise bb.parse.SkipRecipe("Unsupported version %s" % pv)

    m = d.getVar("MACHINE")
    if m == "ls1046apscbc":
        d.appendVar('SRC_URI', ' file://0002-ls1046apscbc-add-config-and-dts-file.patch')
}
