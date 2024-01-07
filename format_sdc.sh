#!/bin/bash
#Author: Xiang Guan Deng.


BOOT_PART=/dev/sdb1
ROOTFS_PART=/dev/sdb2


sudo umount $BOOT_PART
sudo mkfs.vfat $BOOT_PART
mkdir -p /tmp/boot
sudo mount $BOOT_PART /tmp/boot

sudo umount $ROOTFS_PART
sudo mkfs.ext4 $ROOTFS_PART
mkdir -p /tmp/rootfs
sudo mount $ROOTFS_PART /tmp/rootfs


