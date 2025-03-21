FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://0001-enable-emmc-on-rk3399-nanopi-r4s.patch"

ERROR_QA:remove = "patch-status"