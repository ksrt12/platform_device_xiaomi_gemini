LOCAL_PATH:= $(call my-dir)

inishpkg := init.panel.sh init.qcom.sh
inircpkg := init.qcom.usb.rc init.target.rc init.spectrum.rc

# Common config scripts
define dinitsh
include $$(CLEAR_VARS)
LOCAL_MODULE       := $1
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $1
LOCAL_MODULE_PATH  := $$(TARGET_OUT_VENDOR_EXECUTABLES)
include $$(BUILD_PREBUILT)
endef

$(foreach initsh,$(inishpkg),$(eval $(call dinitsh,$(initsh))))

# Common init scripts

include $(CLEAR_VARS)
LOCAL_MODULE       := fstab.qcom
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := fstab.$(LDEV).qcom
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.qcom.$(LDEV).rc
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)/init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.qcom.power.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.qcom.power.$(LDEV).rc
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)/init/hw
include $(BUILD_PREBUILT)

define dinitrc
include $$(CLEAR_VARS)
LOCAL_MODULE       := $1
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $1
LOCAL_MODULE_PATH  := $$(TARGET_OUT_VENDOR_ETC)/init/hw
include $$(BUILD_PREBUILT)
endef

$(foreach initrc,$(inircpkg),$(eval $(call dinitrc,$(initrc))))

include $(CLEAR_VARS)
LOCAL_MODULE       := ueventd.qcom.rc
LOCAL_MODULE_STEM  := ueventd.rc
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := ueventd.qcom.rc
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.spectrum.sh
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := init.spectrum.sh
LOCAL_MODULE_PATH  := $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)
