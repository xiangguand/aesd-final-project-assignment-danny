#!/bin/bash
#Author: Xiang Guan Deng.

set -e

RPI_BOOT_DIR=/tmp/boot

sudo cp u-boot/u-boot.bin $RPI_BOOT_DIR
sudo cp conf/config.txt $RPI_BOOT_DIR
sudo cp conf/cmdline.txt $RPI_BOOT_DIR

### Copy the firmware, boot provided by manufacturer
sudo cp firmware/boot/bootcode.bin $RPI_BOOT_DIR
sudo cp firmware/boot/start.elf $RPI_BOOT_DIR

sudo umount $RPI_BOOT_DIR
