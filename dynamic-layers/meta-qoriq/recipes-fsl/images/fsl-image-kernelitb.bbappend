FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

KERNEL_ITS:qoriq-arm64 = "kernel-arm64-pico.its"

COMPATIBLE_MACHINE = "(ls1046apscb|ls1046apscbc|ls1046apxcp|ls1046apscbx5)"
