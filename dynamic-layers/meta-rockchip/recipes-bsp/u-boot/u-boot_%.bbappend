FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://0001-enable-emmc-ethernet.patch \
	file://0001-u-boot-add-dts-and-config-for-scbxx.patch"

ERROR_QA:remove = "patch-status"