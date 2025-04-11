FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-picocom-ls1046apscb-patch-for-uboot-2024.04.patch \
		file://0002-ls1046apscbc-add-config-and-dts-file.patch \
		"