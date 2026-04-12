SUMMARY = "Prebuilt vendor U-Boot for RK3576"
DESCRIPTION = "Install vendor-provided idbloader and U-Boot images."
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-prebuilt:"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

inherit deploy

SRC_URI = " \
    file://rk3576_spl_loader_v1.09.107.bin \
    file://uboot.img \
"

do_compile() {
    :
}

do_install() {
    install -d ${D}/boot
    install -m 0644 ${UNPACKDIR}/rk3576_spl_loader_v1.09.107.bin ${D}/boot/idbloader.img
    install -m 0644 ${UNPACKDIR}/uboot.img ${D}/boot/u-boot.img
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${UNPACKDIR}/rk3576_spl_loader_v1.09.107.bin ${DEPLOYDIR}/idbloader.img
    install -m 0644 ${UNPACKDIR}/uboot.img ${DEPLOYDIR}/u-boot.img
}
addtask deploy after do_install

INSANE_SKIP:${PN} = "arch file-rdeps ldflags textrel"

PROVIDES += "virtual/bootloader"

FILES:${PN} += "/boot /boot/*"