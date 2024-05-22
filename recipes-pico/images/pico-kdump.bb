require recipes-core/images/core-image-minimal.bb

PACKAGE_ARCH = "${MACHINE_ARCH}"

IMAGE_FSTYPES = "cpio.gz"
INITRAMFS_MAXSIZE = "262144"

SUMMARY = "Small image to be used for save kdump"
DESCRIPTION = "Small image which includes some tools for kernel crash dump."

LICENSE = "MIT"

IMAGE_INSTALL:append = " \
	makedumpfile crash\
"
