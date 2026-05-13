#!/bin/sh

set -e

cd "$(dirname "$0")"
export PATH="${PWD}:${PATH}"

upgrade_tool db loader.bin
upgrade_tool wl 0x0 core-image-base-ok3576.rootfs.wic
upgrade_tool rd
