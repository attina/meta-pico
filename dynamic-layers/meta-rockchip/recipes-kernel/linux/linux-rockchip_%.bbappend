FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

SRC_URI:append = " file://picocom-kmeta;type=kmeta;name=picocom-kmeta;destsuffix=picocom-kmeta"

SRC_URI:append:scb600 = " file://rk3399-picocom.dtsi \
        file://rk3399-picocom-scb600.dts \
        "

SRC_URI:append:scb600 = " file://rk3399-picocom.dtsi \
        file://rk3399-picocom-scb605.dts \
        "

SRC_URI:append:ok3576 = " file://rk3576-forlinx-ok3576.dts \
        file://rk3576-forlinx-common.dtsi \
        file://rk3576-forlinx-cam.dtsi \
        "

do_configure:append:scb600() {
    cp ${UNPACKDIR}/rk3399-picocom.dtsi ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb600.dts ${S}/arch/arm64/boot/dts/rockchip
}

do_configure:append:scb605() {
    cp ${UNPACKDIR}/rk3399-picocom.dtsi ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb605.dts ${S}/arch/arm64/boot/dts/rockchip
}

do_configure:append:ok3576() {
    cp ${UNPACKDIR}/rk3576-forlinx-common.dtsi ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3576-forlinx-cam.dtsi ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3576-forlinx-ok3576.dts ${S}/arch/arm64/boot/dts/rockchip
}

SRC_URI:append:scb600 = " file://picocom-rk3399.scc"
SRC_URI:append:scb605 = " file://picocom-rk3399.scc"
SRC_URI:append:ok3576 = " file://picocom-rk3576.scc"
