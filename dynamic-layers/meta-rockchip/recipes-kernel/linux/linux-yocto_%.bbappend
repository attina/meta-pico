FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE:rk3399 = "rk3399"
COMPATIBLE_MACHINE:rk3576 = "rk3576"

SRC_URI:append = " file://picocom-kmeta;type=kmeta;name=picocom-kmeta;destsuffix=picocom-kmeta"
SRC_URI:append:rk3399 = " file://picocom-rk3399.scc"
SRC_URI:append:rk3576 = " file://picocom-rk3576.scc"