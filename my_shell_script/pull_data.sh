#!/bin/bash
timenow=`date +%Y%m%d%H%M%S`
echo timenow :  ${timenow}

adb devices
adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
adb devices
echo ">>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>  pull data start  >>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>>"

after=`date +%Y%m%d%H%M%S`
echo after :  ${after}


echo ">>>>>>>>>>>>>>>>  pull launcher3 data start  >>>>>>>>>>>>>>>>>>"
#com.android.launcher3
#launcher3 6519
#adb pull /data/data/com.android.launcher3  com.android.launcher3_${after}/
#adb pull /system/system_ext/priv-app/MtkLauncher3QuickStep/   com.android.launcher3_${after}/
#echo ">>>>>>>>>>>>>>>>  pull launcher3 data end  >>>>>>>>>>>>>>>>>>"


#com.android.ServiceMenu
#TopServiceMenu 6519
#adb pull /system/app/TopServiceMenu/  TopServiceMenu_${after}/

#mtklog  暗码:*#*#3646633#*#*
adb pull /data/debuglogger  debuglogger${after}/
#adb pull /storage/emulated/0/debuglogger  debuglogger${after}/


#adb pull  /data/anr/  anr_${after}/
#read -n 1 -p "Press any key to continue..."
#adb reboot

echo ">>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>  pull data end  >>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>----------------->>>>>>>>>>>>>>>>>>"