#!/bin/bash
#Author: Xiang Guan Deng.


BOOT_PART=/dev/sda1
ROOTFS_PART=/dev/sda2


sudo mkfs.vfat $BOOT_PART

sudo mkfs.ext4 $ROOTFS_PART


