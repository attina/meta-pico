include qoriq-atf.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://0001-picocom-ls1046apscb-patch-for-atf-2.8.patch \
		file://0002-ls1046apscbc-add-board-init-code.patch \
		"
SRC_URI:remove = " file://tf-a-tests-no-warn-rwx-segments.patch"