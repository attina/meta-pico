DESCRIPTION = "Vector Packet Processing"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

require vpp-pkgs.inc
SRC_URI = "git://github.com/FDio/vpp;protocol=https;branch=${BRANCH}"

DEPENDS = "gcc-runtime dpdk openssl python3-ply util-linux python3-ply-native numactl"

S = "${WORKDIR}/git"

inherit cmake pkgconfig python3-dir python3native

OECMAKE_SOURCEPATH = "${S}/src"

export ARCH ="aarch64"
export OPENSSL_PATH = "${RECIPE_SYSROOT}/usr"
export DPDK_PATH = "${RECIPE_SYSROOT}/usr"

EXTRA_OECONF = " \
	--with-libtool-sysroot=${SYSROOT} \
	--srcdir=${S}/src \
        --with-pre-data=128 \
        --without-libnuma \
        --without-ipv6sr \
"

CFLAGS += " -ftls-model=local-dynamic -DCLIB_LOG2_CACHE_LINE_BYTES=6 -I${OPENSSL_PATH}/usr/include  -L${OPENSSL_PATH}/lib -Wl,--dynamic-linker=/lib/ld-linux-aarch64.so.1 -latomic"

CFLAGS += " -Wno-address-of-packed-member"

do_configure:prepend() {
	echo "@@@@ Creating libdpdk.a in ${DPDK_PATH}/lib"
	cd ${DPDK_PATH}/lib && \
	echo "GROUP ( "$(ls librte*.a)" )" > libdpdk.a && cd -
}

do_install:append() {
        mkdir -p ${D}/etc/vpp
        cp ${S}/src/vpp/conf/startup.conf ${D}/etc/vpp/startup.conf
        rm -rf ${D}/usr/lib/python*/
}

BBCLASSEXTEND = "native nativesdk"