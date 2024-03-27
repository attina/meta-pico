# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# Unable to find any files that looked like license statements. Check the accompanying
# documentation and source headers and set LICENSE and LIC_FILES_CHKSUM accordingly.
#
# NOTE: LICENSE is being set to "CLOSED" to allow you to at least start building - if
# this is not accurate with respect to the licensing of the software being built (it
# will not be in most cases) you must specify the correct value before using this
# recipe for anything other than initial testing/development!
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "git://git@world-attina/pico/pc802_pcie_driver.git;protocol=ssh;branch=master"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "341e37166cc897aa6254d465b5727f0c005208ac"

S = "${WORKDIR}/git"

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

PROVIDES:${PN} += "kernel-module-pcsc"