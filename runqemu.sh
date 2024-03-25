#!/bin/bash
#Author: Xiang Guan Deng.


qemu-system-aarch64 \
    -M raspi3b  \
    -cpu cortex-a53 -nographic \
    -kernel u-boot/u-boot.bin \
    -dtb buildroot/output/images/bcm2710-rpi-3-b-plus.dtb \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -m 1G \
    -usb -device usb-mouse -device usb-kbd -device usb-tablet \
    -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::9000-:9000

