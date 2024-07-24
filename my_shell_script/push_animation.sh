#!/bin/bash
date

bootanimation_res="/work2/hexiaoming/3909_bootspeed/product_media/bootanimation_02/bootanimation.zip"

adb devices
adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
adb devices
adb wait-for-device
adb shell ls -lha /product/media/
adb shell rm /product/media/bootanimation.zip
adb shell ls -lha /product/media/
adb push ${bootanimation_res} /product/media/bootanimation.zip
adb shell ls -lha /product/media/