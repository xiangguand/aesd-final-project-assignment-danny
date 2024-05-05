
##############################################################
#
# AESD-FINAL
#
# Author: Xiang-Guan
#
##############################################################


AESD_APP_VERSION = 1.0
AESD_APP_SITE = $(BR2_EXTERNAL_XGDEVICE_PATH)/package/aesd-app
AESD_APP_SITE_METHOD = local

define AESD_APP_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(AESD_APP_SITE)/server all
endef


define AESD_APP_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(AESD_APP_SITE)/server/xgserver $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(AESD_APP_SITE)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef


$(eval $(generic-package))
