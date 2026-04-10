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
./rkdeveloptool wl 0x0 core-image-minimal-ok3576.rootfs.wic
./rkdeveloptool rd
