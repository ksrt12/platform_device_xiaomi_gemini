LOCAL_PATH:= $(call my-dir)

inishpkg := init.panel.sh init.qcom.sh init.qcom.usb.sh
inircpkg := init.qcom.rc init.qcom.power.rc

# Common config scripts
define dinitsh
include $$(CLEAR_VARS)
LOCAL_MODULE       := $1
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $1
LOCAL_MODULE_PATH  := $$(TARGET_OUT_VENDOR_EXECUTABLES)
include $$(BUILD_PREBUILT)
endef

$(foreach initsh,$(inishpkg),$(eval $(call dinitsh,$(initsh))))

# Common init scripts

include $(CLEAR_VARS)
LOCAL_MODULE       := fstab.qcom
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := fstab.qcom
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.target.rc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.target.$(LDEV).rc
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)/init/hw
include $(BUILD_PREBUILT)

define dinitrc
include $$(CLEAR_VARS)
LOCAL_MODULE       := $1
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $1
LOCAL_MODULE_PATH  := $$(TARGET_OUT_VENDOR_ETC)/init/hw
include $$(BUILD_PREBUILT)
endef

$(foreach initrc,$(inircpkg),$(eval $(call dinitrc,$(initrc))))

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.qcom.rc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.recovery.qcom.rc
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.usb.rc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
ifeq ($(BUILD_MSM4_4), true)
LOCAL_SRC_FILES    := init.qcom.usb.4.4.rc
else
LOCAL_SRC_FILES    := init.qcom.usb.3.18.rc
endif
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)/init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := ueventd.qcom.rc
LOCAL_MODULE_STEM  := ueventd.rc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := ueventd.qcom.rc
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := rootdir
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
    fstab.qcom \
    init.qcom.rc \
    init.qcom.power.rc \
    init.qcom.usb.rc \
    init.qcom.usb.sh \
    init.qcom.sh \
    init.recovery.qcom.rc \
    init.target.rc \
    ueventd.qcom.rc
include $(BUILD_PHONY_PACKAGE)
