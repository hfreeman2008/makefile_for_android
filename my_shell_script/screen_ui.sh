#!/bin/bash
###############################################################
##脚本使用方法：
##执行：source screen_ui.sh
##截取手机屏幕的脚本
###############################################################

adb devices
adb wait-for-device

RELEASE=`date +%Y%m%d%H%M%S`
#echo $RELEASE
adb shell screencap /sdcard/${RELEASE}.png
adb pull /sdcard/${RELEASE}.png ./
nautilus ./
