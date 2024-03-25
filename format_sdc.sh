#!/bin/bash
#Author: Xiang Guan Deng.


BOOT_PART=/dev/sdb1
ROOTFS_PART=/dev/sdb2


sudo mkfs.vfat $BOOT_PART

sudo mkfs.ext4 $ROOTFS_PART


