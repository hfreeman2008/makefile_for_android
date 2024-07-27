:: author hexiaoming
:: push app to phone
@title "hexiaoming push data bat"
@color 0f

::@echo off



Z:
::cd Z:\hexiaoming\sc780_5_14\out\target\product\qssi
::cd Z:\hexiaoming\sc780_5_14\out\target\product\bengal

::cd Z:\hexiaoming\sc580_R2.0_Pat\out\target\product\qssi
::cd Z:\hexiaoming\sc580_glby\out\target\product\qssi

::cd Z:\hexiaoming\orig_codebase_sc780\out\target\product\qssi
cd Z:\hexiaoming\orig_codebase_sc780\out\target\product\bengal


::adb root
::adb disable-verity
::adb reboot
adb devices
adb wait-for-device
:: sleep 2 second
::choice /t 2 /d y /n >nul
adb root
:: sleep 2 second
::choice /t 2 /d y /n >nul
adb wait-for-device
adb remount
:: sleep 2 second
::choice /t 2 /d y /n >nul
adb wait-for-device



::make Alarm -j64
::Alarm
::com.android.alarm
::set apkName=Alarm
if "%apkName%"=="Alarm" (
adb push system\app\%apkName%  /system/app/
)


::make XyInstallApk -j64
::set apkName=XyInstallApk
if "%apkName%"=="XyInstallApk" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
adb push system\app\%apkName%\oat\arm\%apkName%.odex /system/app/%apkName%/oat/arm/%apkName%.odex
adb push system\app\%apkName%\oat\arm\%apkName%.vdex /system/app/%apkName%/oat/arm/%apkName%.vdex
)





::make Settings -j64
::Settings
::set apkName=Settings
if "%apkName%"=="Settings" (
adb push system_ext\priv-app\%apkName%  /system_ext/priv-app/
)



::make MtkSettings -j64
::MtkSettings
::set apkName=MtkSettings
if "%apkName%"=="MtkSettings" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm\%apkName%.odex /system/priv-app/%apkName%/oat/arm/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm\%apkName%.vdex /system/priv-app/%apkName%/oat/arm/%apkName%.vdex
)


::make XyautoSettings -j64
::XyautoSettings
::set apkName=XyautoSettings
if "%apkName%"=="XyautoSettings" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
)


::PvCanset
::set apkName=PvCanset
if "%apkName%"=="PvCanset" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
adb push system\app\%apkName%\oat\arm\%apkName%.odex /system/app/%apkName%/oat/arm/%apkName%.odex
adb push system\app\%apkName%\oat\arm\%apkName%.vdex /system/app/%apkName%/oat/arm/%apkName%.vdex
)

::PveOtaCheck
::set apkName=PveOtaCheck
if "%apkName%"=="PveOtaCheck" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
)

::MtkMediaProvider
::set apkName=MtkMediaProvider
if "%apkName%"=="MtkMediaProvider" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm\%apkName%.odex /system/priv-app/%apkName%/oat/arm/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm\%apkName%.vdex /system/priv-app/%apkName%/oat/arm/%apkName%.vdex
)



::FMRadio
::set apkName=FMRadio
if "%apkName%"=="FMRadio" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm\%apkName%.odex /system/priv-app/%apkName%/oat/arm/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm\%apkName%.vdex /system/priv-app/%apkName%/oat/arm/%apkName%.vdex
)

::MtkGallery2
::set apkName=MtkGallery2
if "%apkName%"=="MtkGallery2" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
adb push system\app\%apkName%\oat\arm\%apkName%.odex /system/app/%apkName%/oat/arm/%apkName%.odex
adb push system\app\%apkName%\oat\arm\%apkName%.vdex /system/app/%apkName%/oat/arm/%apkName%.vdex
)

::MtkBrowser
::set apkName=MtkBrowser
if "%apkName%"=="MtkBrowser" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
adb push system\app\%apkName%\oat\arm\%apkName%.odex /system/app/%apkName%/oat/arm/%apkName%.odex
adb push system\app\%apkName%\oat\arm\%apkName%.vdex /system/app/%apkName%/oat/arm/%apkName%.vdex
)

::MtkLauncher3
::set apkName=MtkLauncher3
if "%apkName%"=="MtkLauncher3" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm\%apkName%.odex /system/priv-app/%apkName%/oat/arm/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm\%apkName%.vdex /system/priv-app/%apkName%/oat/arm/%apkName%.vdex
)

::set apkName=Launcher3QuickStep
::adb install system\product\priv-app\Launcher3QuickStep\Launcher3QuickStep.apk
if "%apkName%"=="Launcher3QuickStep" (
adb push system\product\priv-app\%apkName%\%apkName%.apk /system/product/priv-app/%apkName%/%apkName%.apk
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)


::set apkName=QDCMMobileApp
if "%apkName%"=="QDCMMobileApp" (
adb push system\product\app\%apkName%\%apkName%.apk /system/product/app/%apkName%/%apkName%.apk
adb push system\product\app\%apkName%\oat\arm64\%apkName%.odex /system/product/app/%apkName%/oat/arm64/%apkName%.odex
adb push system\product\app\%apkName%\oat\arm64\%apkName%.vdex /system/product/app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=SettingsProvider
if "%apkName%"=="SettingsProvider" (
adb push system\priv-app\%apkName% /system/priv-app/
)

::set apkName=MtkSettingsProvider
if "%apkName%"=="MtkSettingsProvider" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm\%apkName%.odex /system/priv-app/%apkName%/oat/arm/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm\%apkName%.vdex /system/priv-app/%apkName%/oat/arm/%apkName%.vdex
)



::set apkName=EmergencyInfo
if "%apkName%"=="EmergencyInfo" (
adb push system\product\priv-app\%apkName%\%apkName%.apk /system/product/priv-app/%apkName%/%apkName%.apk
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=TeleService
if "%apkName%"=="TeleService" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=Telecom
if "%apkName%"=="Telecom" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=Contacts
if "%apkName%"=="Contacts" (
adb push system\product\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=messaging
if "%apkName%"=="messaging" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=QtiDialer
if "%apkName%"=="QtiDialer" (
adb push system\product\priv-app\%apkName%\%apkName%.apk /system/product/priv-app/%apkName%/%apkName%.apk
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)


::set apkName=PackageInstaller
if "%apkName%"=="PackageInstaller" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=XyautoServices
if "%apkName%"=="XyautoServices" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
)

::set apkName=ZlinkActivationCode
if "%apkName%"=="ZlinkActivationCode" (
adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
)

::set apkName=lmkd
if "%apkName%"=="lmkd" (
adb shell ls -lha /system/bin/%apkName%
adb push system\bin\%apkName% /system/bin/%apkName%
adb shell ls -lha /system/bin/%apkName%
)


::thermal-engine
::adb push vendor\bin\thermal-engine /vendor/bin/

::libsurfaceflinger.so
::adb push system\lib\libsurfaceflinger.so /system/lib/libsurfaceflinger.so
::adb push system\lib64\libsurfaceflinger.so /system/lib64/libsurfaceflinger.so
::adb push system\lib\libSurfaceFlingerProp.so /system/lib/libSurfaceFlingerProp.so
::adb push system\lib64\libSurfaceFlingerProp.so /system/lib64/libSurfaceFlingerProp.so

::libhwui.so
::set soName=libhwui
if "%soName%"=="libhwui" (
adb push system\lib\%soName%.so /system/lib/%soName%.so
adb push system\lib64\%soName%.so /system/lib64/%soName%.so
)


::libaudiopolicycustomextensions.so
::set soName=libaudiopolicycustomextensions
if "%soName%"=="libaudiopolicycustomextensions" (
adb push system\lib\%soName%.so /system/lib/%soName%.so
adb push system\lib\libaudiopolicymanagerdefault.so /system/lib/libaudiopolicymanagerdefault.so
adb push system\lib\libzjaudio_jni.so /system/lib/libzjaudio_jni.so
)

::libandroidfw.so
::set soName=libandroidfw
if "%soName%"=="libandroidfw" (
adb push system\lib\%soName%.so /system/lib/%soName%.so
adb push symbols\system\lib\%soName%.so /symbols/system/lib/%soName%.so
)


::libmtkbootanimation.so
::set soName=libmtkbootanimation
if "%soName%"=="libmtkbootanimation" (
adb push system\lib\%soName%.so /system/lib/%soName%.so
adb push symbols\system\lib\%soName%.so /symbols/system/lib/%soName%.so
)

::mtkbootanimation
::set soName=mtkbootanimation
if "%soName%"=="mtkbootanimation" (
adb push system\bin\%soName% /system/bin/%soName%
adb push symbols\system\bin\%soName% /symbols/system/bin/%soName%
)


::adbd
::set fileName=adbd
if "%fileName%"=="adbd" (
adb push system\bin\%fileName% /system/bin/%fileName%
)

::su
::set fileName=su
if "%fileName%"=="su" (
adb push system\xbin\%fileName% /system/xbin/%fileName%
)




::set servicesName=mediatek-services
if "%servicesName%"=="mediatek-services" (
adb push system\framework\oat\arm\mediatek-services.vdex /system/framework/oat/arm/mediatek-services.vdex
adb push system\framework\oat\arm\mediatek-services.odex /system/framework/oat/arm/mediatek-services.odex
adb push system\framework\mediatek-services.jar /system/framework/mediatek-services.jar
)



::make UsbAccessoryChat -j64
::UsbAccessoryChat
::set apkName=UsbAccessoryChat
if "%apkName%"=="UsbAccessoryChat" (
adb push system\app\%apkName%  /system/app/
)

::set apkName=inputflinger
if "%apkName%"=="inputflinger" (
::adb push system\app\%apkName%\%apkName%.apk /system/app/%apkName%/%apkName%.apk
adb push system/bin/inputflinger /system/bin/

adb push system/lib/libinputflinger.so /system/lib/
adb push system/lib/libinputflingerhost.so /system/lib/
adb push system/lib/libinputreader.so /system/lib/
adb push system/lib/libinputflinger_base.so /system/lib/
adb push system/lib/libandroid_runtime.so /system/lib/
adb push system/lib/libandroid.so /system/lib/
adb push system/lib/libservices.core-gnss.so /system/lib/

adb push system/lib64/libinputflinger.so /system/lib64/
adb push system/lib64/libinputflingerhost.so /system/lib64/
adb push system/lib64/libinputreader.so /system/lib64/
adb push system/lib64/libinputflinger_base.so /system/lib64/
adb push system/lib64/libandroid_runtime.so /system/lib64/
adb push system/lib64/libandroid.so /system/lib64/
adb push system/lib64/libservices.core-gnss.so /system/lib64/


)


::set apkName=system_lib
if "%apkName%"=="system_lib" (
adb push system/lib/ /system/
adb push system/lib64/ /system/
)



::make PoliceRecorder -j64
::PoliceRecorder
::com.sc580.policerecorder
::set apkName=PoliceRecorder
if "%apkName%"=="PoliceRecorder" (
adb push system\app\%apkName%  /system/app/
)

::make framework-wifi  -j64
::framework-wifi
::set apkName=framework-wifi
if "%apkName%"=="framework-wifi" (
adb push system\apex\com.android.wifi  /system/apex/
)

::make SystemUpdaterSample  -j64
::SystemUpdaterSample
::set apkName=SystemUpdaterSample
if "%apkName%"=="SystemUpdaterSample" (
adb push system\app\%apkName%  /system/app/
)


::make Qmmi  -j64
::Qmmi
::set apkName=Qmmi
if "%apkName%"=="Qmmi" (
adb push system_ext\app\%apkName%  /system_ext/app/
)

::set apkName=SystemUI
if "%apkName%"=="SystemUI" (
adb push system\product\priv-app\%apkName%\%apkName%.apk /system/product/priv-app/%apkName%/%apkName%.apk
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.odex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.odex
adb push system\product\priv-app\%apkName%\oat\arm64\%apkName%.vdex /system/product/priv-app/%apkName%/oat/arm64/%apkName%.vdex
)

::set apkName=MtkSystemUI
if "%apkName%"=="MtkSystemUI" (
adb push system\priv-app\%apkName%\%apkName%.apk /system/priv-app/%apkName%/%apkName%.apk
adb push system\priv-app\%apkName%\oat\arm\%apkName%.odex /system/priv-app/%apkName%/oat/arm/%apkName%.odex
adb push system\priv-app\%apkName%\oat\arm\%apkName%.vdex /system/priv-app/%apkName%/oat/arm/%apkName%.vdex
)

::make DreamSystemUI  -j64
::DreamSystemUI
::set apkName=DreamSystemUI
if "%apkName%"=="DreamSystemUI" (
adb push system_ext\priv-app\%apkName% /system_ext/priv-app/
)




::make Provision  -j64
::Provision
::set apkName=Provision
if "%apkName%"=="Provision" (
adb push system_ext\priv-app\%apkName% /system_ext/priv-app/
)

::make DreamDevicePolicyServer  -j64
::DreamDevicePolicyServer
::set apkName=DreamDevicePolicyServer
if "%apkName%"=="DreamDevicePolicyServer" (
adb push system\app\%apkName% /system/app/
)


::adb push system\lib\libperfframeinfo_jni.so /system/lib/libperfframeinfo_jni.so

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::mmm system/core/healthd/ -j64
::healthd
::set apkName=healthd
if "%apkName%"=="healthd" (
adb push system\bin\charger /system/bin/
adb push system\bin\healthd /system/bin/
)


::make DreamSettings -j64
::DreamSettings
::set apkName=DreamSettings
if "%apkName%"=="DreamSettings" (
::adb push system_ext\priv-app\%apkName%  /system_ext/priv-app/
call:push_path  system_ext\priv-app\%apkName%  /system_ext/priv-app/
)


::make AutoSdkControl  -j64
::AutoSdkControl
::set apkName=AutoSdkControl
if "%apkName%"=="AutoSdkControl" (
::adb push system\app\%apkName% /system/app/
call:push_path  system\app\%apkName%  /system/app/
)


::make DreamRecorder  -j64
::DreamRecorder
::set apkName=DreamRecorder
if "%apkName%"=="DreamRecorder" (
::adb push system\app\%apkName% /system/app/
call:push_path  system\app\%apkName%  /system/app/
)


::framework-res
::adb push system\framework\framework-res.apk /system/framework/framework-res.apk


::framework services
::adb push system\framework /system/framework
::adb push system\framework /system/
::call:push_path system\framework /system/


::make sepolicy  -j64
::mmma system/sepolicy
::out\target\product\bengal
::sepolicy
set apkName=sepolicy
if "%apkName%"=="sepolicy" (
adb push vendor\etc\selinux  /vendor/etc/
adb push system\etc\selinux  /system/etc/
::adb push root\sepolicy  /root/
)

pause

:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::call:reboot:::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
call:reboot
pause


:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::call:power_shutdown:::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
::call:power_shutdown
::pause

:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::reboot::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
:reboot
::if errorlevel 0 adb reboot
adb reboot
goto:eof



:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::power_shutdown::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::
:power_shutdown
::if errorlevel 0 adb shell svc power shutdown
adb shell svc power shutdown
goto:eof


:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::function defined start::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::

::call:push_path_system_app DreamDevicePolicyServer
::call:push_path_system_priv_app DreamDevicePolicyServer
::call:push_path system\app\DreamDevicePolicyServer  system\app\

:push_path
::echo push_path First para:%1
::echo push_path Second para:%2
adb push %1 %2
goto:eof



:push_path_system_app
::echo push_path_system_app First:%1
set apk_name_temp=%1
::echo push_path_system_app %apk_name_temp%
adb push  system\app\%apk_name_temp% /system/app/
goto:eof


:push_path_system_priv_app
::echo push_path_system_priv_app First:%1
set apk_name_temp=%1
adb push  system\priv-app\%apk_name_temp% /system/priv-app/
goto:eof

:::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::function defined end::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::