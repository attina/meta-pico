
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit kernel
inherit kernel-yocto

# --- Source Configuration ---
SRC_URI:ok3576 = "git://github.com/attina/linux.git;protocol=https;branch=rel/forlinx/ok3576/linux-6.1"
SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"

SRCREV = "${AUTOREV}"

LINUX_VERSION_EXTENSION = "-rockchip"
KERNEL_VERSION_SANITY_SKIP = "1"
INSANE_SKIP:linux-rockchip-src += "buildpaths"

# --- Fix for Rockchip Kernel Build Deps ---
# Rockchip kernels often need openssl and other tools for signing/image creation
DEPENDS += "openssl-native util-linux-native"

# If the kernel requires specific DTB compilation flags
DTC_FLAGS += "-@"

# Standard Yocto kernel variables
PV = "${LINUX_VERSION}+git${SRCPV}"