DESCRIPTION = "Vector Packet Processing"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

BRANCH = "stable/2402"
SRCREV = "500ac0596126576e278e65a64597e8b87fdc55f8"
S = "${WORKDIR}/git"
PV = "24.02.0"

SRC_URI = "git://github.com/FDio/vpp;protocol=https;branch=${BRANCH} \
	"

DEPENDS += "dpdk openssl numactl libpcap"

inherit cmake

OECMAKE_SOURCEPATH = "${S}/src"
EXTRA_OECMAKE += "-DCMAKE_SKIP_RPATH=TRUE"

include vpp-pkgs.inc