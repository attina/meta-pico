include rockchip-rkbin-common.inc

DDRBIN_VERS:rk3576 ?= "v1.09"
DDRBIN_FILE:rk3576 ?= "rk3576_ddr_lp4_2112MHz_lp5_2736MHz_${DDRBIN_VERS}.bin"

do_deploy:rk3576() {
	# Prebuilt U-Boot TPL (DDR init)
	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3576.bin
}
