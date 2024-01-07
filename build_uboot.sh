#!/bin/bash
#Author: Xiang Guan Deng.

make -C u-boot CROSS_COMPILE=aarch64-linux-gnu- rpi_3_b_plus_defconfig
make -C u-boot CROSS_COMPILE=aarch64-linux-gnu-

