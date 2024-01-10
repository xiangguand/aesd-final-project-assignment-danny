
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

### Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = 'e37c6d49228ed2b680ab60a6e07a0e26859de6e9'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
# LDD_VERSION = 1.0.0
LDD_SITE = 'git@github.com:ZXPAY/aesd-ldd3.git'


LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

# LDD_SITE = /home/danny/Desktop/workspace/advancedEmbeddedSoftwareDevelopment/assignment7/aesd-assignment7-buildroot/ldd3

# LDD_SOURCE = $(BR2_EXTERNAL_Assignment7_PATH)/../ldd3

LDD_MODULE_SUBDIRS = misc-modules scull
# LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

# define LDD_BUILD_CMDS
# 	echo $(@D)
# 	$(MAKE) -C $(@D)
# endef

# define LDD_INSTALL_TARGET_CMDS
#	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
# endef

$(eval $(kernel-module))
$(eval $(generic-package))
