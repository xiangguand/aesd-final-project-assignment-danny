
##############################################################
#
# AESD-FINAL
#
# Author: Xiang-Guan
#
##############################################################


AESD_FINAL_VERSION = 1.0
AESD_FINAL_SITE = $(BR2_EXTERNAL_XGDEVICE_PATH)/package/aesd-final
AESD_FINAL_SITE_METHOD = local

define AESD_FINAL_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/aesdfinal_load $(TARGET_DIR)/etc/init.d/S99aesddevicedriver
	$(INSTALL) -m 0755 $(@D)/aesdfinal_unload $(TARGET_DIR)/usr/bin
endef


$(eval $(kernel-module))
$(eval $(generic-package))
