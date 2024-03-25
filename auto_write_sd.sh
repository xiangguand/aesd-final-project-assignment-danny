#!/bin/bash
#Author: Xiang Guan Deng.

set -e

sudo dd if=buildroot/output/images/rootfs.ext4 of=/dev/sda2 bs=4M

RPI_BOOT_DIR=/tmp/boot

#sudo umount /tmp/boot
sudo mount /dev/sda1 /tmp/boot


# Override u-boot and config files
sudo cp rpi-u-boot/u-boot.bin $RPI_BOOT_DIR
sudo cp conf/config.txt $RPI_BOOT_DIR
sudo cp conf/cmdline.txt $RPI_BOOT_DIR
sudo cp buildroot/output/images/Image $RPI_BOOT_DIR

### Override the firmware, boot provided by manufacturer
sudo cp firmware/boot/bootcode.bin $RPI_BOOT_DIR
sudo cp firmware/boot/start.elf $RPI_BOOT_DIR
sudo cp firmware/boot/bcm*-rpi-3*.dtb $RPI_BOOT_DIR




