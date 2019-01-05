LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := recovery_updater.cpp
LOCAL_MODULE := librecovery_updater_gemini
LOCAL_MODULE_TAGS := eng
LOCAL_STATIC_LIBRARIES := libupdater libotautil libedify

include $(BUILD_STATIC_LIBRARY)
