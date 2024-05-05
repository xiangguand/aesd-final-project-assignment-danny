
##############################################################
#
# AESD-FINAL
#
# Author: Xiang-Guan
#
##############################################################


AESD_SENSOR_VERSION = 1.0
AESD_SENSOR_SITE = $(BR2_EXTERNAL_XGDEVICE_PATH)/package/aesd-sensor
AESD_SENSOR_SITE_METHOD = local

define AESD_SENSOR_INSTALL_TARGET_CMDS

endef

$(eval $(generic-package))
