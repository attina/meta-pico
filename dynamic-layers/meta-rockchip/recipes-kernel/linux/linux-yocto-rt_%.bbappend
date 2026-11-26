require linux-yocto-pico.inc

KERNEL_FEATURES:append:rockchip = " common/preempt-rt.scc"
