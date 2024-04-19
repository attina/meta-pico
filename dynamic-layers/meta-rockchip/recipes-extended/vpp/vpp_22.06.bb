BRANCH = "stable/2206"
SRCREV = "1513b381d8879d9d437bbbc9a270b4ff5f4b19ba"
PV = "22.06.1"

require vpp-core.inc

SRC_URI += " file://0001-vpp-core-fix-package_qa-error.patch"