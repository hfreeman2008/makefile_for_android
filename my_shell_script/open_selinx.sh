#!/bin/bash
date
adb devices
adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
adb devices

adb shell getenforce
adb shell setenforce 1
adb shell getenforce