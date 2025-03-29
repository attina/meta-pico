# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
#
# The following license files were not able to be identified and are
# represented as "Unknown" below, you will need to check them yourself:
#   LICENSE
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5430828348d2cf7d4b5e8395f774a68e"

SRC_URI = "git://git@github.com/alpinelinux/apk-tools.git;protocol=ssh;branch=master"

# Modify these as desired
PV = "3.0.0-rc4+git"
SRCREV = "3abcd400bdbfc61a2f53f7cf7b240130169154b2"

S = "${WORKDIR}/git"
DEPENDS = "zlib zstd openssl"

inherit meson pkgconfig

do_install:append() {
    rm -rf ${D}${libdir}/python3.12/
}