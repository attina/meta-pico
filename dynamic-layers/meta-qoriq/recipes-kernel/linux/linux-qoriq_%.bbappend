FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

python __anonymous () {
    pv = d.getVar('PV')
    if pv.startswith("6.12"):
        d.appendVar('SRC_URI', ' file://patch-6.12.28-rt10.patch')
    elif pv.startswith("6.6"):
        d.appendVar('SRC_URI', ' file://patch-6.6.52-rt43.patch')
    else:
        raise bb.parse.SkipRecipe("Unsupported version %s" % pv)

    if d.getVar('UNPACKDIR') is None:
        d.setVar('UNPACKDIR', d.getVar('WORKDIR'))
}

SRC_URI += " file://ls1046apscb.cfg \
        file://0001-sdk-fman-map-1000basex-to-sgmii-basex.patch \
        "
SRC_URI:append:ls1046apscb = " file://fsl-ls1046a-pscb.dts \
        file://fsl-ls1046a-pscb-sdk.dts \
        file://fsl-ls1046a-pscb-usdpaa.dts \
        file://fsl-ls1046a-pscb_mac9.dts \
        file://fsl-ls1046a-pscb-sdk_mac9.dts \
        file://fsl-ls1046a-pscb-usdpaa_mac9.dts \
        "
SRC_URI:append:ls1046apscbc = " file://fsl-ls1046a-pscbc.dts \
        file://fsl-ls1046a-pscbc-sdk.dts \
        file://fsl-ls1046a-pscbc-usdpaa.dts \
        file://fsl-ls1046a-pscbc-puyu2.dts \
        file://fsl-ls1046a-pscbc-puyu2-sdk.dts \
        file://fsl-ls1046a-pscbc-puyu2-usdpaa.dts \
        "
SRC_URI:append:ls1046apxcp = " file://fsl-ls1046a-pxcp.dts \
        file://fsl-ls1046a-pxcp-sdk.dts \
        file://fsl-ls1046a-pxcp-usdpaa.dts \
        file://fsl-ls1046a-pxcp-cscn.dts \
        file://fsl-ls1046a-pxcp-cscn-sdk.dts \
        file://fsl-ls1046a-pxcp-cscn-usdpaa.dts \
        file://fsl-ls1046a-pxcp-xwyy-sdk.dts \
        "
SRC_URI:append:ls1046apscbx5 = " file://fsl-ls1046a-pscbx5.dts \
        file://fsl-ls1046a-pscbx5-sdk.dts \
        file://fsl-ls1046a-pscbx5-usdpaa.dts \
        "

# Include the kernel SCM state in our own localversion so it can appear
# before the generated patch/DTS/CFG metadata.
SCMVERSION = "n"

python __anonymous () {
    import hashlib
    import os
    import oe.patch
    import bb.fetch2

    # Use the patches that BitBake will actually apply, in SRC_URI order.
    patches = oe.patch.src_patches(d)
    patch_items = []
    for patch in patches:
        _, _, local, _, _, parm = bb.fetch2.decodeurl(patch)
        name = parm.get('patchname') or os.path.basename(local)
        if os.path.isfile(local):
            with open(local, 'rb') as patch_file:
                digest = hashlib.sha256(patch_file.read()).hexdigest()
        else:
            # Keep metadata parsing possible for patches fetched later.
            digest = 'missing'
        patch_items.append('%s:%s' % (name, digest))

    def items_hash(items):
        return hashlib.sha256('\n'.join(items).encode('utf-8')).hexdigest()

    # Include DTS and CFG files from the effective SRC_URI as well.
    fetch = bb.fetch2.Fetch([], d)
    source_items = {'dts': [], 'cfg': []}
    for uri in fetch.urls:
        scheme, _, path, _, _, parm = bb.fetch2.decodeurl(uri)
        if scheme != 'file':
            continue

        local = fetch.localpath(uri)
        name = os.path.basename(local or path)
        kind = os.path.splitext(name)[1].lower().lstrip('.')
        if kind not in source_items:
            continue

        if local and os.path.isfile(local):
            with open(local, 'rb') as source_file:
                digest = hashlib.sha256(source_file.read()).hexdigest()
        else:
            digest = 'missing'
        source_items[kind].append('%s:%s' % (name, digest))

    patchset_digest = items_hash(patch_items)
    dts_digest = items_hash(source_items['dts'])
    cfg_digest = items_hash(source_items['cfg'])
    all_items = (['patch:%s' % item for item in patch_items] +
                 ['dts:%s' % item for item in source_items['dts']] +
                 ['cfg:%s' % item for item in source_items['cfg']])
    input_digest = items_hash(all_items)
    patchset_id = 'ps%02d-%s' % (len(patch_items), patchset_digest[:8])
    release_base = ('ps%02d-d%s-c%s-%s' %
                    (len(patch_items), len(source_items['dts']),
                     len(source_items['cfg']), input_digest[:8]))

    d.setVar('PICO_KERNEL_PATCHSET_ID', patchset_id)
    d.setVar('PICO_KERNEL_PATCHSET_HASH', patchset_digest)
    d.setVar('PICO_KERNEL_PATCHSET_FILES', ' '.join(item.split(':', 1)[0] for item in patch_items))
    d.setVar('PICO_KERNEL_DTS_COUNT', str(len(source_items['dts'])))
    d.setVar('PICO_KERNEL_DTS_HASH', dts_digest)
    d.setVar('PICO_KERNEL_DTS_FILES', ' '.join(item.split(':', 1)[0] for item in source_items['dts']))
    d.setVar('PICO_KERNEL_CFG_COUNT', str(len(source_items['cfg'])))
    d.setVar('PICO_KERNEL_CFG_HASH', cfg_digest)
    d.setVar('PICO_KERNEL_CFG_FILES', ' '.join(item.split(':', 1)[0] for item in source_items['cfg']))
    d.setVar('PICO_KERNEL_INPUT_HASH', input_digest)
    d.setVar('PICO_KERNEL_RELEASE_BASE', release_base)

    # Anonymous Python may be evaluated more than once while reparsing
    # metadata. Remove a previously generated suffix before rebuilding it.
    import re
    localversion = d.getVar('KERNEL_LOCALVERSION') or ''
    localversion = re.sub(
        r'(?:-ps[0-9]+-d[0-9]+-c[0-9]+-[0-9a-f]{8}-\$\(date -u \+%Y%m%d\))+$',
        '', localversion)
    if localversion and not localversion.startswith('-'):
        localversion = '-%s' % localversion

    # KERNEL_VERSION already includes localversion/SCM suffixes in this
    # recipe; LINUX_VERSION is the kernel's unextended base version.
    kernel_version = d.getVar('LINUX_VERSION') or d.getVar('KERNEL_VERSION')
    scm_localversion = (
        '$(%s/scripts/setlocalversion --no-local ${S} | sed "s/^%s//")' %
        ('${S}', kernel_version))

    # Evaluate the date in the task shell so metadata remains deterministic.
    d.setVar('KERNEL_LOCALVERSION',
             '%s%s-%s-$(date -u +%%Y%%m%%d)' %
             (scm_localversion, localversion, release_base))
}

export LOCALVERSION = "${KERNEL_LOCALVERSION}"

do_configure:append() {
    sed -i -e '/^CONFIG_LOCALVERSION_AUTO[ =]/d' ${B}/.config
    echo 'CONFIG_LOCALVERSION_AUTO=n' >> ${B}/.config
}

do_configure:prepend:ls1046apxcp() {
    rm -f "${B}/.scmversion" "${S}/.scmversion"
}

do_configure:append:ls1046apscb() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscb.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscb-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscb-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscb_mac9.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscb-sdk_mac9.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscb-usdpaa_mac9.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb_mac9.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb-sdk_mac9.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscb-usdpaa_mac9.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

do_configure:append:ls1046apscbc() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    # for puyu2 peripheral board
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc-puyu2.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc-puyu2-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbc-puyu2-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc-puyu2.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc-puyu2-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbc-puyu2-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

do_configure:append:ls1046apxcp() {
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-cscn.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-cscn-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-cscn-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pxcp-xwyy-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-cscn.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-cscn-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-cscn-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pxcp-xwyy-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

do_configure:append:ls1046apscbx5() {
    cp ${UNPACKDIR}/fsl-ls1046a-pscbx5.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbx5-sdk.dts ${S}/arch/arm64/boot/dts/freescale
    cp ${UNPACKDIR}/fsl-ls1046a-pscbx5-usdpaa.dts ${S}/arch/arm64/boot/dts/freescale
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbx5.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbx5-sdk.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
    echo "dtb-\$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-pscbx5-usdpaa.dtb" >> ${S}/arch/arm64/boot/dts/freescale/Makefile
}

DELTA_KERNEL_DEFCONFIG += "ls1046apscb.cfg"
