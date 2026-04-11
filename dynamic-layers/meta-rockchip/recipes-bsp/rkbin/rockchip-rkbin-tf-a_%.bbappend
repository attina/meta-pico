include rockchip-rkbin-common.inc

do_deploy:rk3576() {
	# Prebuilt TF-A
	install -d ${DEPLOYDIR}/trusted-firmware-a
	install -m 644 ${S}/bin/rk35/rk3576_bl31_v*.elf ${DEPLOYDIR}/trusted-firmware-a/bl31.elf
}
