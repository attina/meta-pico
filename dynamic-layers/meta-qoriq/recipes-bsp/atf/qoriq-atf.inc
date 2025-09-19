RCW_FOLDER:ls1046apscb = "ls1046apscb"
RCW_FOLDER:ls1046apscbc = "ls1046apscbc"
RCW_FOLDER:ls1046apxcp = "ls1046apxcp"

RCW_SUFFIX:ls1046a = "${@bb.utils.contains('DISTRO_FEATURES', 'secure', '_sben.bin', '.bin', d)}"

BOOTTYPE:ls1046apscb = "qspi sd"
BOOTTYPE:ls1046apscbc = "qspi sd emmc"
BOOTTYPE:ls1046apxcp = "qspi sd emmc"

COMPATIBLE_MACHINE = "(ls1046apscb|ls1046apscbc|ls1046apxcp)"