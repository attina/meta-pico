DESCRIPTION = "Vector Packet Processing"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

SRC_URI = "git://github.com/FDio/vpp;protocol=https;branch=${BRANCH} \
	"
S = "${WORKDIR}/git"

DEPENDS += "dpdk openssl numactl libpcap"

inherit cmake python3native
DEPENDS += "python3-ply-native"

OECMAKE_SOURCEPATH = "${S}/src"
EXTRA_OECMAKE += "-DCMAKE_SKIP_RPATH=TRUE"

include vpp-pkgs.inc