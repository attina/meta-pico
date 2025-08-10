FILESEXTRAPATHS:prepend := "${THISDIR}/secure-boot-qoriq:"

BOOT_TYPE:ls1046apscb ?= "qspi sd"
BOOT_TYPE:ls1046apscbc ?= "qspi sd emmc"
