FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# preempt_rt patch
SRC_URI += "file://patch-6.6.52-rt43.patch \
        "

SRC_URI += "file://0001-picocom-ls1046apscb-patch-for-linux-6.6.patch \
        file://0003-ls1046apscbc-add-device-tree.patch \
        file://ls1046apscb.cfg \
        "

DELTA_KERNEL_DEFCONFIG += "ls1046apscb.cfg"