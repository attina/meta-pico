FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

python __anonymous () {
    pv = d.getVar('PV')
    if pv.startswith("2025.04"):
        d.appendVar('SRC_URI', ' file://0001-picocom-ls1046a-series-board-driver.patch')
    elif pv.startswith("2024.04") or pv.startswith("2023.04") or pv.startswith("2021.04"):
        d.appendVar('SRC_URI', ' file://0001-picocom-ls1046a-series-board-driver-for-2024.04.patch')
    else:
        raise bb.parse.SkipRecipe("Unsupported version %s" % pv)

    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

SRC_URI:append:ls1046apscb = " file://fsl-ls1046a-pscb.dts \
        file://ls1046apscb_tfa_defconfig \
        file://ls1046apscb_tfa_SECURE_BOOT_defconfig \
        "
SRC_URI:append:ls1046apscbc = " file://fsl-ls1046a-pscbc.dts \
        file://ls1046apscbc_tfa_defconfig \
        file://ls1046apscbc_tfa_SECURE_BOOT_defconfig \
        "
SRC_URI:append:ls1046apxcp = " file://fsl-ls1046a-pxcp.dts \
        file://ls1046apxcp_tfa_defconfig \
        file://ls1046apxcp_tfa_SECURE_BOOT_defconfig \
        "
SRC_URI:append:ls1046apscbx5 = " file://fsl-ls1046a-pscbx5.dts \
        file://ls1046apscbx5_tfa_defconfig \
        file://ls1046apscbx5_tfa_SECURE_BOOT_defconfig \
        "

do_configure:prepend:ls1046apscb() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscb.dts ${S}/arch/arm/dts
    sed -i '3i\dtb-$(CONFIG_FSL_LSCH2) += fsl-ls1046a-pscb.dtb' ${S}/arch/arm/dts/Makefile
    cp ${UNPACKDIR}/ls1046apscb_tfa_defconfig ${S}/configs
    cp ${UNPACKDIR}/ls1046apscb_tfa_SECURE_BOOT_defconfig ${S}/configs
}

do_configure:prepend:ls1046apscbc() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc.dts ${S}/arch/arm/dts
    sed -i '3i\dtb-$(CONFIG_FSL_LSCH2) += fsl-ls1046a-pscbc.dtb' ${S}/arch/arm/dts/Makefile
    cp ${UNPACKDIR}/ls1046apscbc_tfa_defconfig ${S}/configs
    cp ${UNPACKDIR}/ls1046apscbc_tfa_SECURE_BOOT_defconfig ${S}/configs
}

do_configure:prepend:ls1046apxcp() {
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp.dts ${S}/arch/arm/dts
    sed -i '3i\dtb-$(CONFIG_FSL_LSCH2) += fsl-ls1046a-pxcp.dtb' ${S}/arch/arm/dts/Makefile
    cp ${UNPACKDIR}/ls1046apxcp_tfa_defconfig ${S}/configs
    cp ${UNPACKDIR}/ls1046apxcp_tfa_SECURE_BOOT_defconfig ${S}/configs
}

do_configure:prepend:ls1046apscbx5() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscbx5.dts ${S}/arch/arm/dts
    sed -i '3i\dtb-$(CONFIG_FSL_LSCH2) += fsl-ls1046a-pscbx5.dtb' ${S}/arch/arm/dts/Makefile
    cp ${UNPACKDIR}/ls1046apscbx5_tfa_defconfig ${S}/configs
    cp ${UNPACKDIR}/ls1046apscbx5_tfa_SECURE_BOOT_defconfig ${S}/configs
}