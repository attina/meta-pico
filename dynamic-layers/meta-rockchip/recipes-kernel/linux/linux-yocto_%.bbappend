FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE:rk3399 = "rk3399"
COMPATIBLE_MACHINE:rk3576 = "rk3576"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

# OK3576 is based on 6.1.84 with forlinx patches
KBRANCH:rk3576 = "v6.1/standard/preempt-rt/base"
SRCREV_machine:rk3576 = "4df82ffbb2b0f0b0efb545d1f67e61c987d051c1"
LINUX_VERSION = "6.1.84"

SRC_URI:append = " file://picocom-kmeta;type=kmeta;name=picocom-kmeta;destsuffix=picocom-kmeta"

SRC_URI:append:rk3399 = " file://rk3399-picocom.dtsi \
        file://rk3399-picocom-scb600.dts \
        file://rk3399-picocom-scb605.dts \
        "

do_configure:append:scb600() {
    cp ${UNPACKDIR}/rk3399-picocom.dtsi ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb600.dts ${S}/arch/arm64/boot/dts/rockchip
}

do_configure:append:scb605() {
    cp ${UNPACKDIR}/rk3399-picocom.dtsi ${S}/arch/arm64/boot/dts/rockchip
    cp ${UNPACKDIR}/rk3399-picocom-scb605.dts ${S}/arch/arm64/boot/dts/rockchip
}

SRC_URI:append:rk3399 = " file://picocom-rk3399.scc"
SRC_URI:append:rk3576 = " file://picocom-rk3576.scc"

INSANE_SKIP:${PN}-src += "buildpaths"
