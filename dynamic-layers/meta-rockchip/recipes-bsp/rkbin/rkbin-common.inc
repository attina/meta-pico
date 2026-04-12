SRCREV = "74213af1e952c4683d2e35952507133b61394862"

COMPATIBLE_MACHINE:rk3576 = "rk3576"

RKBIN_BINDIR:rk3576 ?= "bin/rk35/"

python __anonymous () {
    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

S = "${UNPACKDIR}/${PN}-git"

INSANE_SKIP:${PN} += "license-checksum"