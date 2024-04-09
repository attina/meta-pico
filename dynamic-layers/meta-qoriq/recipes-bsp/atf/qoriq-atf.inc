RCW_FOLDER:ls1046apscb = "ls1046apscb"

RCW_SUFFIX:ls1046a = "${@bb.utils.contains('DISTRO_FEATURES', 'secure', '_sben.bin', '.bin', d)}"

BOOTTYPE:ls1046apscb = "qspi sd"

COMPATIBLE_MACHINE = "ls1046apscb"