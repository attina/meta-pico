DESCRIPTION = "Data Plane Development Kit"
HOMEPAGE = "http://dpdk.org"
LICENSE = "BSD-3-Clause & LGPL-2.1-only & GPL-2.0-only"
LIC_FILES_CHKSUM = "file://license/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
                    file://license/lgpl-2.1.txt;md5=4b54a1fd55a448865a0b32d41598759d \
                    file://license/bsd-3-clause.txt;md5=0f00d99239d922ffd13cabef83b33444"

SRC_URI = "git://github.com/nxp-qoriq/dpdk;protocol=https;nobranch=1"
SRCREV = "80c5b4d6355d1dbece8dd1f812d374f3e24086bc"

S = "${WORKDIR}/git"

CVE_PRODUCT = "data_plane_development_kit"
