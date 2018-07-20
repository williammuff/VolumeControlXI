PACKAGE_VERSION = 1.0.0
FINALPACKAGE=1
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VolumeControlXI
VolumeControlXI_FILES = Tweak.xm
VolumeControlXI_PRIVATE_FRAMEWORKS = MediaRemote AppSupport

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
