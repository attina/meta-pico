SOC_FAMILY = "rk3576"

DEFAULTTUNE ?= "cortexa72-cortexa53-crypto"

ROCKCHIP_CLOSED_TPL ?= "1"

require conf/machine/include/soc-family.inc
require conf/machine/include/rockchip-defaults.inc
require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
require conf/machine/include/rockchip-wic.inc

KBUILD_DEFCONFIG ?= "defconfig"
KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"

MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
KERNEL_CLASSES += "kernel-fit-extra-artifacts"
KERNEL_IMAGETYPE = "Image.gz"

PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"

UBOOT_SUFFIX ?= "img"
UBOOT_ENTRYPOINT ?= "0x40200000"
UBOOT_MACHINE ?= "rk3576_defconfig"

TFA_PLATFORM = "rk3576"
TFA_BUILD_TARGET = "bl31"

ENABLE_STATELESS_VPU_GST ?= "1"

SERIAL_CONSOLES = "1500000;ttyS0"
