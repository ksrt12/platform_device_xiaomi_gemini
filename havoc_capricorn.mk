#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from capricorn device
$(call inherit-product, device/xiaomi/gemini/device.mk)
PRODUCT_PACKAGES += Snap

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := havoc_capricorn
PRODUCT_DEVICE := capricorn
PRODUCT_MODEL := MI 5s
PRODUCT_BRAND := Xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE="capricorn" \
    PRODUCT_NAME="capricorn" \
    PRIVATE_BUILD_DESC="capricorn-user 7.0 NRD90M V9.5.4.0.NAGMIFD release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := "Xiaomi/capricorn/capricorn:7.0/NRD90M/V9.5.4.0.NAGMIFD:user/release-keys"

# Inherit some common Havoc stuff.
$(call inherit-product, vendor/havoc/config/common.mk)
