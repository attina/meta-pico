FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

python __anonymous () {
    pv = d.getVar('PV')
    if pv.startswith("6.12"):
        d.appendVar('SRC_URI', ' file://patch-6.12.28-rt10.patch')
    elif pv.startswith("6.6"):
        d.appendVar('SRC_URI', ' file://patch-6.6.52-rt43.patch')
    else:
        raise bb.parse.SkipRecipe("Unsupported version %s" % pv)
}

SRC_URI += " file://ls1046apscb.cfg \
        "
SRC_URI:append:ls1046apscb = " file://fsl-ls1046a-pscb.dts \
        file://fsl-ls1046a-pscb-sdk.dts \
        file://fsl-ls1046a-pscb-usdpaa.dts \
        "
SRC_URI:append:ls1046apscbc = " file://fsl-ls1046a-pscbc.dts \
        file://fsl-ls1046a-pscbc-sdk.dts \
        file://fsl-ls1046a-pscbc-usdpaa.dts \
        "
SRC_URI:append:ls1046apxcp = " file://fsl-ls1046a-pxcp.dts \
        file://fsl-ls1046a-pxcp-sdk.dts \
        file://fsl-ls1046a-pxcp-usdpaa.dts \
        "
SRC_URI:append:ls1046apxcp = " file://fsl-ls1046a-pxcp-cscn.dts \
        file://fsl-ls1046a-pxcp-cscn-sdk.dts \
        file://fsl-ls1046a-pxcp-cscn-usdpaa.dts \
        "
SRC_URI:append:ls1046apscbx5 = " file://fsl-ls1046a-pscbx5.dts \
        file://fsl-ls1046a-pscbx5-sdk.dts \
        file://fsl-ls1046a-pscbx5-usdpaa.dts \
        "

do_configure:append:ls1046apscb() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscb.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscb-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscb-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

do_configure:append:ls1046apscbc() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

do_configure:append:ls1046apxcp() {
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-cscn.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-cscn-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-cscn-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-cscn.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-cscn-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-cscn-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

do_configure:append:ls1046apscbx5() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscbx5.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbx5-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbx5-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbx5.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbx5-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbx5-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

DELTA_KERNEL_DEFCONFIG += "ls1046apscb.cfg"