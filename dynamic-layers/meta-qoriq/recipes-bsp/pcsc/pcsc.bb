# recipe for picocom pc802 pcie kernel driver and test program
# Gavin Gao <attinagaoxu@gmail.com>
require pcsc.inc

inherit module

EXTRA_OEMAKE += "KERNEL_DIR=${STAGING_KERNEL_DIR}"

MODULES_MODULE_SYMVERS_LOCATION = "drv"

do_compile() {
    # build kernel module only
    oe_runmake modules
}

do_install:append(){
    # install test application
    install -d ${D}/lib/firmware/pico
    install -m 0644 ${WORKDIR}/pc802.img ${D}/lib/firmware/pico
    install -m 0644 ${WORKDIR}/pc802.ssbl ${D}/lib/firmware/pico
}

PACKAGES =+ "${PN}-firmware"
RDEPENDS_kernel-module-${PN} = "${PN}-firmware"

FILES:${PN}-firmware += " \
    /lib/firmware/pico/pc802.img \
    /lib/firmware/pico/pc802.ssbl \
    "

INSANE_SKIP:${PN}-firmware += "arch"