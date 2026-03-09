#!/bin/bash

export PATH=.:${PATH}
./rkdeveloptool --version
./rkdeveloptool db boot.bin
if [ $? -ne 0 ]; then
    exit 1
fi

for i in {5..1}; do
    printf "Waiting %d seconds...\r" "$i"
    sleep 1
done
echo "Done!"
./rkdeveloptool rid
./rkdeveloptool ef
./rkdeveloptool wl 0x40 idbloader.img
./rkdeveloptool wl 0x4000 u-boot.img
./rkdeveloptool wl 0x8000 boot.bin
./rkdeveloptool wl 0x40000 core-image-minimal-ok3576.rootfs.wic
./rkdeveloptool rd
