DESCRIPTION = "Python script dpdk"
LICENSE = "CLOSED"
SRC_URI = "file://src/dpdk-devbind.py"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

S = "${UNPACKDIR}/src"

do_install() {
    install -d ${D}${bindir}  # Install to /etc in rootfs
    install -m 0755 ${S}/dpdk-devbind.py ${D}${bindir}/dpdk-devbind.py
}

FILES:${PN} = "${bindir}/dpdk-devbind.py"