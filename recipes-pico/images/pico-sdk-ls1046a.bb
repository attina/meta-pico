require recipes-core/images/core-image-minimal.bb

PACKAGE_ARCH = "${MACHINE_ARCH}"

IMAGE_FSTYPES = "tar.gz"

SUMMARY = "Small image to be used for evaluating the Picocom board"
DESCRIPTION = "Small image which includes some helpful tools and \
Picocom-specific packages."

LICENSE = "MIT"

IMAGE_INSTALL:append = " \
    packagegroup-core-ssh-openssh packagegroup-pico-base \
    kernel-modules e2fsprogs-mke2fs python3 python3-pip \
    cjson libpcap dpdk-devbind libatomic lrzsz htop iperf2 \
    libgpiod-tools \
"

DEPENDS:append:qoriq = " \
    secure-boot-qoriq \
    flex-installer \
    qoriq-composite-firmware \
    generate-boottgz \
"