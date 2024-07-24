#!/bin/bash
date
adb devices
adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
adb devices

adb shell ls -ha /system/media/audio/alarms
adb shell rm -rf /system/media/audio/alarms
adb shell ls -ha /system/media/audio/alarms

read -n 1 -p "Press any key to continue..."
adb reboot
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>  adb reboot  >>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
