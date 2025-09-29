FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE:rk3399 = "rk3399"
COMPATIBLE_MACHINE:rk3576 = "rk3576"

python __anonymous () {
    pv = d.getVar('PV')
    machine = d.getVar('MACHINE')

    if machine == "scb600" or machine == "scb605":
        if pv.startswith("6.12"):
            d.appendVar('SRC_URI', ' file://0001-scb6xx-add-dts-file-for-scb600-and-scb605.patch')
        elif pv.startswith("6.6"):
            d.appendVar('SRC_URI', ' file://0001-scb6xx-add-dts-file-for-scb600-and-scb605-6.6.patch')
}

SRC_URI:append = " file://picocom-kmeta;type=kmeta;name=picocom-kmeta;destsuffix=picocom-kmeta"
SRC_URI:append:rk3399 = " file://picocom-rk3399.scc"
SRC_URI:append:rk3576 = " file://picocom-rk3576.scc"

ERROR_QA:remove = "patch-status"