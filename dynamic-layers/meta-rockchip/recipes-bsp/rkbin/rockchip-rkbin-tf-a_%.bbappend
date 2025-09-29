SRCREV = "74213af1e952c4683d2e35952507133b61394862"

COMPATIBLE_MACHINE:rk3576 = "rk3576"

do_deploy:rk3576() {
	# Prebuilt TF-A
	install -m 644 ${S}/bin/rk35/rk3576_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3576.elf
}
