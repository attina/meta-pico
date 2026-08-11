SUMMARY = "Rockchip WiFi firmware files from rkwifibt"
SECTION = "kernel"
LICENSE = "CLOSED"

SRCREV = "2db7beca9637cc25f6bb6ce73a4d59cb0d0ffa68"
SRC_URI = "git://github.com/attina/rkwifibt.git;protocol=https;branch=develop"

PACKAGE_ARCH = "${MACHINE_ARCH}"

RKWIFIBT_FIRMWARE_MODULE ?= ""
RKWIFIBT_FIRMWARE_MODULE[doc] = "rkwifibt WiFi module name, for example AP6256 or CYW4373."
RKWIFIBT_FIRMWARE_BOARD_TYPE ?= ""
RKWIFIBT_FIRMWARE_BOARD_TYPE[doc] = "Optional brcmfmac board type used for board-specific firmware symlinks."

python do_install() {
    import os
    import shutil

    module = d.getVar("RKWIFIBT_FIRMWARE_MODULE")
    board_type = d.getVar("RKWIFIBT_FIRMWARE_BOARD_TYPE")
    s = d.getVar("S")
    destdir = os.path.join(
        d.getVar("D"),
        d.getVar("nonarch_base_libdir").lstrip("/"),
        "firmware",
        "brcm",
    )

    firmware_map = {
        "AP6212A1": {
            "source": "firmware/broadcom/AP6212A1/wifi",
            "firmware": "fw_bcm43438a1.bin",
            "nvram": "nvram_ap6212a.txt",
            "target": "brcmfmac43430-sdio",
        },
        "AP6255": {
            "source": "firmware/broadcom/AP6255/wifi",
            "firmware": "fw_bcm43455c0_ag.bin",
            "nvram": "nvram_ap6255.txt",
            "target": "brcmfmac43455-sdio",
        },
        "AP6256": {
            "source": "firmware/broadcom/AP6256/wifi",
            "firmware": "fw_bcm43456c5_ag.bin",
            "nvram": "nvram_ap6256.txt",
            "clm": "brcmfmac43456-sdio.clm_blob",
            "target": "brcmfmac43456-sdio",
        },
        "AP6275S": {
            "source": "firmware/broadcom/AP6275S/wifi",
            "firmware": "fw_bcm43752a2_ag.bin",
            "nvram": "nvram_ap6275s.txt",
            "clm": "clm_bcm43752a2_ag.blob",
            "target": "brcmfmac43752-sdio",
        },
        "AP6275_PCIE": {
            "source": "firmware/broadcom/AP6275_PCIE/wifi",
            "firmware": "fw_bcm43752a2_pcie_ag.bin",
            "nvram": "nvram_ap6275p.txt",
            "clm": "clm_bcm43752a2_pcie_ag.blob",
            "target": "brcmfmac43752-pcie",
        },
        "AP6354": {
            "source": "firmware/broadcom/AP6354/wifi",
            "firmware": "fw_bcm4354a1_ag.bin",
            "nvram": "nvram_ap6354.txt",
            "target": "brcmfmac4354-sdio",
        },
        "AP6356": {
            "source": "firmware/broadcom/AP6356/wifi",
            "firmware": "fw_bcm4356a2_ag.bin",
            "nvram": "nvram_ap6356.txt",
            "target": "brcmfmac4356-sdio",
        },
        "AP6398S": {
            "source": "firmware/broadcom/AP6398S/wifi",
            "firmware": "fw_bcm4359c0_ag.bin",
            "nvram": "nvram_ap6398s.txt",
            "target": "brcmfmac4359-sdio",
        },
        "CYW43012": {
            "source": "firmware/infineon/CYW43012",
            "firmware": "cyw43012.bin",
            "nvram": "cyw43012.txt",
            "clm": "cyw43012.clm_blob",
            "target": "brcmfmac43012-sdio",
        },
        "CYW43438": {
            "source": "firmware/infineon/CYW43438",
            "firmware": "cyw43438.bin",
            "nvram": "cyw43438.txt",
            "target": "brcmfmac43430-sdio",
        },
        "CYW43455": {
            "source": "firmware/infineon/CYW43455",
            "firmware": "cyw43455.bin",
            "nvram": "cyw43455.txt",
            "clm": "cyw43455.clm_blob",
            "target": "brcmfmac43455-sdio",
        },
        "CYW4354": {
            "source": "firmware/infineon/CYW4354",
            "firmware": "cyw4354.bin",
            "nvram": "cyw4354.txt",
            "clm": "cyw4354.clm_blob",
            "target": "brcmfmac4354-sdio",
        },
        "CYW4373": {
            "source": "firmware/infineon/CYW4373",
            "firmware": "cyw4373.bin",
            "nvram": "cyw4373.txt",
            "clm": "cyw4373.clm_blob",
            "target": "brcmfmac4373-sdio",
        },
        "CYW54591_PCIE": {
            "source": "firmware/infineon/CYW54591_PCIE",
            "firmware": "cyw54591_pcie.bin",
            "nvram": "cyw54591_pcie.txt",
            "clm": "cyw54591.clm_blob",
            "target": "brcmfmac54591-pcie",
        },
    }

    if not module:
        bb.fatal("RKWIFIBT_FIRMWARE_MODULE must be set by the machine configuration")

    fw = firmware_map.get(module)
    if not fw:
        bb.fatal("Unsupported RKWIFIBT_FIRMWARE_MODULE '%s'. Supported modules: %s" %
                 (module, ", ".join(sorted(firmware_map))))

    os.makedirs(destdir, exist_ok=True)

    srcdir = os.path.join(s, fw["source"])
    shutil.copyfile(
        os.path.join(srcdir, fw["firmware"]),
        os.path.join(destdir, fw["target"] + ".bin"),
    )
    shutil.copyfile(
        os.path.join(srcdir, fw["nvram"]),
        os.path.join(destdir, fw["target"] + ".txt"),
    )

    if fw.get("clm"):
        shutil.copyfile(
            os.path.join(srcdir, fw["clm"]),
            os.path.join(destdir, fw["target"] + ".clm_blob"),
        )

    if board_type:
        for suffix in ("bin", "txt", "clm_blob"):
            filename = fw["target"] + "." + suffix
            board_filename = fw["target"] + "." + board_type + "." + suffix
            target = os.path.join(destdir, filename)
            board_target = os.path.join(destdir, board_filename)
            if os.path.exists(target):
                os.symlink(filename, board_target)
}

FILES:${PN} = "${nonarch_base_libdir}/firmware/brcm/*"
