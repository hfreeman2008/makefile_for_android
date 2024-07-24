#!/bin/bash
date
adb devices
adb wait-for-device
adb root
adb wait-for-device
adb remount
adb wait-for-device
adb devices

#3909
#root_apk=/work2/codebase/3909_2023_3_7/idh.code/out/target/product/tb8765ap1_bsp_1g

#T6 6519
root_apk=/home/hexiaoming/code/6519_t/idh.code/out_sys/target/product/mssi_t_64_cn
#root_apk=/home/hexiaoming/code/6519_t/idh.code/out_sys/target/product/mssi_t_64_cn_datasms


#Z1018
#root_apk=/home/hexiaoming/code/1018/idh.code/out_sys/target/product/mssi_t_64_cn
#root_apk=/home/hexiaoming/code/1018/idh.code/out_sys/target/product/mssi_t_64_cn

#push_path_app_apk
push_path_app_apk()
{
    local apkName_temp=$1
    echo "apkName_temp=${apkName_temp}"
    local apkPath_temp=$2
    echo "apkPath_temp=${apkPath_temp}"
    
    echo "apkName=${apkName}"
    echo "apkPath=${apkPath}"
    if [ ${apkName} = ${apkName_temp} ] ; then
#        adb push ${root_apk}/system/app/${apkName}/${apkName}.apk ${apkPath}${apkName}/${apkName}.apk
        adb push ${root_apk}${apkPath}${apkName} ${apkPath}
        adb shell ls -lha ${apkPath}${apkName}/*
        echo ">>>>>>>>>>>>>>>>  finish push apk: ${apkName}  >>>>>>>>>>>>>>>>>>"
    fi
}

push_bootanimation()
{
    local apkName_temp=$1
    echo "apkName_temp=${apkName_temp}"
    echo "apkName=${apkName}"
    if [ ${apkName} = ${apkName_temp} ] ; then
        adb push ${root_apk}/system/etc/init/bootanim.rc /system/etc/init/bootanim.rc
        adb push ${root_apk}/system/lib64/libbootanimation.so /system/lib64/libbootanimation.so
        adb push ${root_apk}/system/bin/bootanimation /system/bin/bootanimation

        adb shell ls -lha /system/etc/init/bootanim.rc
        adb shell ls -lha /system/lib64/libbootanimation.so
        adb shell ls -lha /system/bin/bootanimation
        echo ">>>>>>>>>>>>>>>>  finish push apk: ${apkName}  >>>>>>>>>>>>>>>>>>"
    fi
}


#push_sepolicy
push_sepolicy()
{
root/sepolicy
    local apkName_temp=$1
    echo "apkName_temp=${apkName_temp}"
    echo "apkName=${apkName}"
    if [ ${apkName} = ${apkName_temp} ] ; then
        adb push ${root_apk}/root/sepolicy  /
        adb shell ls -lha /sepolicy
        echo ">>>>>>>>>>>>>>>>  finish push apk: ${apkName}  >>>>>>>>>>>>>>>>>>"
    fi
}


# push_system_services
push_system_services()
{
adb push ${root_apk}/system/framework/oat/arm64/services.vdex  system/framework/oat/arm64/services.vdex
adb push ${root_apk}/system/framework/oat/arm64/services.odex  system/framework/oat/arm64/services.odex
adb push ${root_apk}/system/framework/oat/arm64/services.art   system/framework/oat/arm64/services.art

adb push ${root_apk}/system/framework/oat/arm/services.vdex  system/framework/oat/arm/services.vdex
adb push ${root_apk}/system/framework/oat/arm/services.odex  system/framework/oat/arm/services.odex
adb push ${root_apk}/system/framework/oat/arm/services.art   system/framework/oat/arm/services.art
#adb shell ls -lha /system/framework/oat/arm64/services.*

adb push ${root_apk}/system/framework/services.jar.prof   system/framework/services.jar.prof
adb push ${root_apk}/system/framework/services.jar.bprof   system/framework/services.jar.bprof
adb push ${root_apk}/system/framework/services.jar   system/framework/services.jar
#adb shell ls -lha /system/framework/services.*

echo ">>>>>>>>>>>>>>>>  finish push apk: ${apkName}  >>>>>>>>>>>>>>>>>>"
}


# push_framework_v13
push_framework_v13()
{
#android 13 t6 6519
adb push ${root_apk}/system/framework /system/


#adb push ${root_apk}/system/framework /system/framework/
#adb shell ls -lha /system/framework/
adb shell ls -lha /system/ | grep framework
echo ">>>>>>>>>>>>>>>>  finish push  ${apkName}  >>>>>>>>>>>>>>>>>>"
}

# push_framework_v11
push_framework_v11()
{
#android 13 t6 6519
#adb push ${root_apk}/system/framework /system/

# android 11 3909
adb push ${root_apk}/system/framework /system/framework/
#adb shell ls -lha /system/framework/
adb shell ls -lha /system/ | grep framework
echo ">>>>>>>>>>>>>>>>  finish push  ${apkName}  >>>>>>>>>>>>>>>>>>"
}

# push_framework-res_app_apk
push_framework-res_app_apk()
{

    local apkName_temp=$1
    echo "apkName_temp=${apkName_temp}"
    local apkPath_temp=$2
    echo "apkPath_temp=${apkPath_temp}"
    
    echo "apkName=${apkName}"
    echo "apkPath=${apkPath}"
    if [ ${apkName} = ${apkName_temp} ] ; then
        adb push ${root_apk}${apkPath}${apkName}.apk ${apkPath}/
        
        adb shell ls -lha ${apkPath}/ | grep ${apkName}
        echo ">>>>>>>>>>>>>>>>  finish push apk: ${apkName}  >>>>>>>>>>>>>>>>>>"
    fi
}
################################################################################################################################
################################################################################################################################

#services
#apkName=services
#push_system_services  "$apkName"

#framework
#framework-minus-apex
# t6 z6519 v13 
apkName=framework
push_framework_v13  "$framework"

#framework
#framework-minus-apex
# 3909 v11
#apkName=framework
#push_framework_v11  "$framework"


#framework-res
#apkName=framework-res
#apkPath=/system/framework/
#push_framework-res_app_apk  "$apkName" "$apkPath"


#Camera
#apkName=Camera
#apkPath=/system/system_ext/app/
#push_path_app_apk  "$apkName" "$apkPath"

#MtkSystemUI
#apkName=MtkSystemUI
#apkPath=/system/system_ext/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"

#MtkSettingsProvider
#com.android.providers.settings
#/system/priv-app/MtkSettingsProvider/MtkSettingsProvider.apk
#apkName=MtkSettingsProvider
#apkPath=/system/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"

#MtkLauncher3QuickStepGo
#apkName=MtkLauncher3QuickStepGo
#apkPath=/system/system_ext/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"


#MtkLauncher3QuickStep  6519
#apkName=MtkLauncher3QuickStep
#apkPath=/system/system_ext/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"


#MtkSettings
#apkName=MtkSettings
#apkPath=/system/system_ext/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"

#MtkDialer
#apkName=MtkDialer
#apkPath=/system/system_ext/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"



#Dialer
#apkName=Dialer
#apkPath=/product/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"


#EngineerMode
#apkName=EngineerMode
#apkPath=/system/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"



#MtkTelecom
#apkName=MtkTelecom
#apkPath=/system/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"


#MtkTeleService
#apkName=MtkTeleService
#apkPath=/system/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"


#sepolicy
#apkName=sepolicy
#push_sepolicy  "$apkName"


#Camera  /system/system_ext/app/Camera/Camera.apk
#apkName=Camera
#apkPath=/system/system_ext/app/
#push_path_app_apk  "$apkName" "$apkPath"


#TopServiceMenu  /system/app/TopServiceMenu/TopServiceMenu.apk
#apkName=TopServiceMenu
#apkPath=/system/app/
#push_path_app_apk  "$apkName" "$apkPath"

# com.android.phone
# MtkTeleService /system/priv-app/MtkTeleService/MtkTeleService.apk
#apkName=MtkTeleService
#apkPath=/system/priv-app/
#push_path_app_apk  "$apkName" "$apkPath"


#bootanimation
#apkName=bootanimation
#push_bootanimation "$apkName"

read -n 1 -p "Press any key to continue..."

adb reboot
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>  adb reboot  >>>>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
