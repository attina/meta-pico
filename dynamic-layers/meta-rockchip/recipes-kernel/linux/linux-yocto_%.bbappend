FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE:rk3399 = "rk3399"
COMPATIBLE_MACHINE:rk3576 = "rk3576"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

SRC_URI:append = " file://picocom-kmeta;type=kmeta;name=picocom-kmeta;destsuffix=picocom-kmeta"

SRC_URI:append = " file://rk3399-picocom.dtsi \
        file://rk3399-picocom-scb600.dts \
        file://rk3399-picocom-scb605.dts \
        "

do_configure:append() {
    cp ${UNPACKDIR}/rk3399-picocom.dtsi ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb600.dts ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb605.dts ${S}/arch/arm64/boot/dts/rockchip
    echo "dtb-\$(CONFIG_ARCH_ROCKCHIP) += rk3399-picocom-scb600.dtb" >> ${S}/arch/arm64/boot/dts/rockchip/Makefile
    echo "dtb-\$(CONFIG_ARCH_ROCKCHIP) += rk3399-picocom-scb605.dtb" >> ${S}/arch/arm64/boot/dts/rockchip/Makefile
}

SRC_URI:append:rk3399 = " file://picocom-rk3399.scc"
SRC_URI:append:rk3576 = " file://picocom-rk3576.scc"
