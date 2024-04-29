# recipe for picocom pc802 pcie kernel driver and test program
# Gavin Gao <attinagaoxu@gmail.com>

require pcsc.inc

do_install:append(){
    # install test application
    install -d ${D}/usr/local/bin
    install -m 0755 ${S}/examples/pcitest ${D}/usr/local/bin/
    install -m 0755 ${S}/examples/pcsc_test ${D}/usr/local/bin/
}

FILES:${PN} += "/usr/local/bin/pcitest"
FILES:${PN} += "/usr/local/bin/pcsc_test"

TARGET_CC_ARCH += "${LDFLAGS}"