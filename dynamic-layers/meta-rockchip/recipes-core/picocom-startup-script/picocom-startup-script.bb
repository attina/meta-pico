DESCRIPTION = "Picocom startup script"
HOMEPAGE = "https://www.picocom.com"
MAINTAINER = "Gavin Gao <attinagaoxu@gmail.com>"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

S = "${WORKDIR}"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
            file://run-for-picocom.sh \
"

INITSCRIPT_NAME = "run-for-picocom.sh"
INITSCRIPT_PARAMS = "start 99 2 3 4 5 ."

inherit update-rc.d

do_install() {
    install -m 0755 ${WORKDIR}/run-for-picocom.sh -D ${D}${sysconfdir}/init.d/run-for-picocom.sh
}
