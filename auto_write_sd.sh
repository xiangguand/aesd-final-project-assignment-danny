#!/bin/bash
#Author: Xiang Guan Deng.

set -e

RPI_BOOT_DIR=/tmp/boot


sudo dd if=buildroot/output/images/rootfs.ext4 of=/dev/sda2 bs=4M

echo "===== Write rootfs complate ====="

mkdir -p $RPI_BOOT_DIR
sudo mount /dev/sda1 /tmp/boot

mkdir -p /tmp/rootfs
sudo mount /dev/sda2 /tmp/rootfs

sudo cp "./buildroot/output/images/bcm2710-rpi-3-b.dtb" $RPI_BOOT_DIR
sudo cp "./buildroot/output/images/bcm2710-rpi-3-b-plus.dtb" $RPI_BOOT_DIR
sudo cp "./buildroot/output/images/bcm2837-rpi-3-b.dtb" $RPI_BOOT_DIR
sudo cp "./buildroot/output/images/rpi-firmware/bootcode.bin" $RPI_BOOT_DIR
sudo cp "./buildroot/output/images/rpi-firmware/fixup.dat" $RPI_BOOT_DIR
sudo cp -r "./buildroot/output/images/rpi-firmware/overlays" $RPI_BOOT_DIR
sudo cp "./buildroot/output/images/rpi-firmware/start.elf" $RPI_BOOT_DIR
# sudo cp "./buildroot/output/images/rpi-firmware/cmdline.txt" $RPI_BOOT_DIR
# sudo cp "./buildroot/output/images/rpi-firmware/config.txt" $RPI_BOOT_DIR
# sudo cp "./buildroot/output/images/Image" $RPI_BOOT_DIR

# Override u-boot and config files
sudo cp rpi-u-boot/u-boot.bin $RPI_BOOT_DIR
sudo cp conf/config.txt $RPI_BOOT_DIR
sudo cp conf/cmdline.txt $RPI_BOOT_DIR
sudo cp buildroot/output/images/Image $RPI_BOOT_DIR

### Override the firmware, boot provided by manufacturer
# sudo cp firmware/boot/bootcode.bin $RPI_BOOT_DIR
# sudo cp firmware/boot/start.elf $RPI_BOOT_DIR
# sudo cp firmware/boot/bcm*-rpi-3*.dtb $RPI_BOOT_DIR

./umount_sd.sh

echo "===== Complete ====="

