#!/bin/sh
# Shared definitions for buildroot scripts

# The defconfig from the buildroot directory we use for qemu builds
QEMU_DEFCONFIG=configs/raspberrypi3_64_defconfig
# The place we store customizations to the qemu configuration
MODIFIED_DEFCONFIG=base_external/configs/xg_project_defconfig
# The defconfig from the buildroot directory we use for the project
AESD_DEFAULT_DEFCONFIG=${MODIFIED_DEFCONFIG}
AESD_MODIFIED_DEFCONFIG=${MODIFIED_DEFCONFIG}
AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT=../${AESD_MODIFIED_DEFCONFIG}
