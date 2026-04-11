include rockchip-rkbin-common.inc

do_deploy:rk3576() {
	# Prebuilt OPTEE-OS
	install -m 644 ${S}/bin/rk35/rk3576_bl32_v*.bin ${DEPLOYDIR}/tee-rk3576.bin
}
