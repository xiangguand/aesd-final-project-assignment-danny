#!/bin/bash
#Author: Xiang Guan Deng.

make -C rpi-u-boot CROSS_COMPILE=aarch64-linux-gnu- rpi_3_b_plus_xiangguan_defconfig
make -C rpi-u-boot CROSS_COMPILE=aarch64-linux-gnu-

