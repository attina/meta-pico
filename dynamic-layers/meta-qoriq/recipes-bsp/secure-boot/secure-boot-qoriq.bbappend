FILESEXTRAPATHS:prepend := "${THISDIR}/secure-boot-qoriq:"

QORIQ_SECUREBOOT_SUPPORTED_MACHINES = "${MACHINE}"

BOOT_TYPE:ls1046apscb ?= "qspi sd"
BOOT_TYPE:ls1046apscbc ?= "qspi sd emmc"
BOOT_TYPE:ls1046apxcp ?= "qspi sd emmc"
BOOT_TYPE:ls1046apscbx5 ?= "qspi sd emmc"
