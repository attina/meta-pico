# recipe for picocom pc802 pcie kernel driver and test program
# Gavin Gao <attinagaoxu@gmail.com>
require pcsc.inc

inherit module

EXTRA_OEMAKE:append:task-install = " -C ${STAGING_KERNEL_DIR} M=${S}/drv"
EXTRA_OEMAKE += "KERNEL_DIR=${STAGING_KERNEL_DIR}"

MODULES_MODULE_SYMVERS_LOCATION = "drv"

do_compile() {
    # build kernel module only
    oe_runmake modules
}