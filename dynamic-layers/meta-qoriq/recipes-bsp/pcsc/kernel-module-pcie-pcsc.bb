# recipe for picocom pc802 pcie kernel driver and test program
# Gavin Gao <attinagaoxu@gmail.com>

require pcie-pcsc.inc

inherit module

EXTRA_OEMAKE:append:task-install = " -C ${STAGING_KERNEL_DIR} M=${S}"
EXTRA_OEMAKE += "KERNEL_DIR=${STAGING_KERNEL_DIR}"

MODULES_MODULE_SYMVERS_LOCATION = "drv"

do_compile() {
    # build kernel module only
    oe_runmake modules
}

do_install:append(){
    # install the kernel module
    install -d ${D}/lib/modules/${KERNEL_VERSION}/extra
    install -m 0644 ${S}/drv/pcsc.ko ${D}/lib/modules/${KERNEL_VERSION}/extra/
}

FILES:${PN} += "/lib/modules/${KERNEL_VERSION}/extra/pcsc.ko"