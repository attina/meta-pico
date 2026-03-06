FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

DEPENDS:append = " gnutls-native"

SRC_URI:append:scb600 = " file://picocom-scb600_defconfig \
        file://rk3399-picocom-u-boot.dtsi \
        file://rk3399-picocom-scb600-u-boot.dtsi \
        file://rk3399-picocom-scb600.dts \
        "

SRC_URI:append:scb605 = " file://picocom-scb605_defconfig \
        file://rk3399-picocom-u-boot.dtsi \
        file://rk3399-picocom-scb605-u-boot.dtsi \
        file://rk3399-picocom-scb605.dts \
        "

SRC_URI:append:rk3576 = " file://0001-rk3576-enable-compress-support.patch"

do_configure:prepend:scb600() {
    cp ${UNPACKDIR}/rk3399-picocom-u-boot.dtsi ${S}/arch/arm/dts
    cp ${UNPACKDIR}/rk3399-picocom-scb600-u-boot.dtsi ${S}/arch/arm/dts
    cp ${UNPACKDIR}/rk3399-picocom.dtsi ${S}/dts/upstream/src/arm64/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb600.dts ${S}/dts/upstream/src/arm64/rockchip
    cp ${UNPACKDIR}/picocom-scb600_defconfig ${S}/configs
}

do_configure:prepend:scb600() {
    cp ${UNPACKDIR}/rk3399-picocom-u-boot.dtsi ${S}/arch/arm/dts
    cp ${UNPACKDIR}/rk3399-picocom-scb600-u-boot.dtsi ${S}/arch/arm/dts
    cp ${UNPACKDIR}/rk3399-picocom.dtsi ${S}/dts/upstream/src/arm64/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb600.dts ${S}/dts/upstream/src/arm64/rockchip
    cp ${UNPACKDIR}/picocom-scb600_defconfig ${S}/configs
}

ERROR_QA:remove = "patch-status"