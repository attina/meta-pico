include qoriq-atf.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-picocom-ls1046apscb-patch-for-atf-2.8.patch"
