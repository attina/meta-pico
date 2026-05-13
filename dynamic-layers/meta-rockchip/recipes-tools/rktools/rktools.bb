SUMMARY = "Rockchip flashing utilities and scripts"
DESCRIPTION = "Install Rockchip flashing tools and flash.sh into the image deploy directory"
LICENSE = "CLOSED"

inherit bin_package deploy

SRC_URI = "file://flash.sh \
        file://rkdeveloptool \
        file://upgrade_tool \
        "

S = "${UNPACKDIR}"

do_install() {
	# Nothing in this recipe is useful in a filesystem
	:
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0755 ${S}/rkdeveloptool ${DEPLOYDIR}/rkdeveloptool
    install -m 0755 ${S}/upgrade_tool ${DEPLOYDIR}/upgrade_tool
    install -m 0755 ${S}/flash.sh ${DEPLOYDIR}/flash.sh
}

addtask deploy after do_install
