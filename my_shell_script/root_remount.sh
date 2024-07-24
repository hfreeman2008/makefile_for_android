#!/bin/bash
date
adb devices
adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
adb devices
