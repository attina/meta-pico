FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE:scb600 = "scb600"
COMPATIBLE_MACHINE:scb605 = "scb605"

SRC_URI:append = " file://picocom-kmeta;type=kmeta;name=picocom-kmeta;destsuffix=picocom-kmeta"
SRC_URI:append = " file://picocom-rk-scb6xx.scc"