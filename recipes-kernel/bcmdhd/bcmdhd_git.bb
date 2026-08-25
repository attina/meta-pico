SUMMARY = "Broadcom BCMDHD SDIO driver for AP6256"
DESCRIPTION = "Vendor Broadcom DHD driver with BCM43456/AP6256 SDIO support."
SECTION = "kernel"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://Makefile;md5=78229f555bd772d630d18831bdd1f810"

inherit module

# The legacy compatibility patch has an intentional context shift after the
# obsolete-header removal.
ERROR_QA:remove = "patch-fuzz"

COMPATIBLE_MACHINE = "rk3576"
PACKAGE_ARCH = "${MACHINE_ARCH}"

PV = "1.0+git${SRCPV}"
SRCREV = "a57fb69f427cdea9f18ac91d65df67c0d5572935"
SRC_URI = "git://github.com/attina/broadcom-bcmdhd.git;protocol=https;branch=users/gavin/kernel-6.18 \
           file://config.txt"

EXTRA_OEMAKE += " \
    KBUILD_ABS_SRCTREE=0 \
    KCFLAGS="${KCFLAGS}" \
    CONFIG_BCMDHD=m \
    CONFIG_BCMDHD_SDIO=y \
    CONFIG_BCMDHD_OOB=y \
    CONFIG_DHD_USE_STATIC_BUF=y \
    CONFIG_BCMDHD_STATIC_BUF_IN_DHD=y \
    CONFIG_MACH_PLATFORM=y \
    CONFIG_BCMDHD_DTS=y \
    CONFIG_CFG80211=y \
    CONFIG_MMC=y \
"

KCFLAGS += " \
    -fdebug-prefix-map=${S}=. \
    -fmacro-prefix-map=${S}=. \
    -ffile-prefix-map=${S}=. \
    -fdebug-prefix-map=${STAGING_KERNEL_DIR}=. \
    -fmacro-prefix-map=${STAGING_KERNEL_DIR}=. \
    -ffile-prefix-map=${STAGING_KERNEL_DIR}=. \
    -fdebug-prefix-map=${STAGING_KERNEL_BUILDDIR}=. \
    -fmacro-prefix-map=${STAGING_KERNEL_BUILDDIR}=. \
    -ffile-prefix-map=${STAGING_KERNEL_BUILDDIR}=. \
"

do_compile() {
    oe_runmake -C ${STAGING_KERNEL_BUILDDIR} M=${S} modules
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
    install -m 0644 ${S}/bcmdhd.ko \
        ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/bcmdhd.ko

    install -d ${D}${sysconfdir}/modprobe.d
    install -d ${D}${sysconfdir}/modules-load.d
    install -d ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${UNPACKDIR}/config.txt ${D}${sysconfdir}/bcmdhd-ap6256-config.txt
    printf '%s\n' bcmdhd > ${D}${sysconfdir}/modules-load.d/bcmdhd.conf
    ln -sf brcmfmac43456-sdio.picocom,rk3576acp.bin \
        ${D}${nonarch_base_libdir}/firmware/brcm/fw_bcm43456c5_ag.bin
    ln -sf brcmfmac43456-sdio.picocom,rk3576acp.clm_blob \
        ${D}${nonarch_base_libdir}/firmware/brcm/clm_bcm43456c5_ag.blob
    cat > ${D}${sysconfdir}/modprobe.d/bcmdhd-ap6256.conf <<'EOF'
blacklist brcmfmac
blacklist brcmutil
options bcmdhd firmware_path=/lib/firmware/brcm/brcmfmac43456-sdio.picocom,rk3576acp.bin nvram_path=/lib/firmware/brcm/brcmfmac43456-sdio.picocom,rk3576acp.txt clm_path=/lib/firmware/brcm/brcmfmac43456-sdio.picocom,rk3576acp.clm_blob config_path=/etc/bcmdhd-ap6256-config.txt
EOF
}

FILES:${PN} += " \
    ${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/bcmdhd.ko \
    ${sysconfdir}/modprobe.d/bcmdhd-ap6256.conf \
    ${sysconfdir}/modules-load.d/bcmdhd.conf \
    ${nonarch_base_libdir}/firmware/brcm/fw_bcm43456c5_ag.bin \
    ${nonarch_base_libdir}/firmware/brcm/clm_bcm43456c5_ag.blob \
    ${sysconfdir}/bcmdhd-ap6256-config.txt \
"

RDEPENDS:${PN} += "rkwifibt-firmware"
RPROVIDES:${PN} += "kernel-module-bcmdhd kernel-module-bcmdhd-${KERNEL_VERSION}"
KERNEL_MODULE_AUTOLOAD += "bcmdhd"
