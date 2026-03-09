FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE:rk3399 = "rk3399"
COMPATIBLE_MACHINE:rk3576 = "rk3576"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

#LINUX_VERSION = "6.6.0"
#KBRANCH = "openEuler-24.03-LTS"

#SRC_URI = "git://atomgit.com/openeuler/rockchip-kernel.git;name=machine;branch=${KBRANCH};protocol=https \
#           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=yocto-6.6;destsuffix=${KMETA};protocol=https"

#SRCREV_machine = "5e898a44caa84e70bbc64664b9dc42094b1d8bdb"
#SRCREV_meta = "45f69741c733e066ed1a12b6025e347e5cd6063e"

#KBUILD_DEFCONFIG = "OK3568-C-linux_defconfig"

SRC_URI:append = " file://picocom-kmeta;type=kmeta;name=picocom-kmeta;destsuffix=picocom-kmeta"

SRC_URI:append:rk3399 = " file://rk3399-picocom.dtsi \
        file://rk3399-picocom-scb600.dts \
        file://rk3399-picocom-scb605.dts \
        "

SRC_URI:append:rk3576 = " file://rk3576-forlinx-ok3576.dts \
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
    cp ${UNPACKDIR}/rk3576-forlinx-ok3576.dts ${S}/arch/arm64/boot/dts/rockchip
}

SRC_URI:append:rk3399 = " file://picocom-rk3399.scc"
SRC_URI:append:rk3576 = " file://picocom-rk3576.scc"
