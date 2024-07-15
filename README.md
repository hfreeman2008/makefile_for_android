# makefile_for_android

这篇文章主要是一个对于android开发时常用的makefile(mk)笔记。

# 指定编译文件

指定特定的Makefile，你可以使用make的“-f”和“–file”参数.

```makefile
make -f Make.Linux
make –file Make.AIX
make -f test.mk
```

***


# 打印log

```makefile
$(error  " test   $(is-vendor-board-platform)")
$(error  " test   0001")
$(warning $(TARGET_ARCH))  
$(info test,hehe)  
```

***

# 注释

\# 开头

```makefile
# -------------------------------------------------------------
#                     START
# -------------------------------------------------------------
```

***

# 自定义变量

以下是在 Android.mk中依赖或定义的变量列表，可以定义其他变量为自己使用，但是NDK编译系统保留下列变量名：

-以 LOCAL_开头的名字（例如 LOCAL_MODULE）

-以 PRIVATE_, NDK_ 或 APP_开头的名字（内部使用）

-小写名字（内部使用，例如‘my-dir’）


如果为了方便在 Android.mk 中定义自己的变量，建议使用 MY_前缀，一个小例子：

```makefile
#-----------------start----------------
my_value = hello
$(warning ----my_value:$(my_value))
#-----------------end----------------
```

注意：
- ‘:=’是赋值的意思；
- ’+=’是追加的意思；
- ‘$’表示引用某变量的值

***

# 冒号等于操作符–”:=“

前面的变量不能使用后面的变量，只能使用前面已定义好了的变量。

```makefile
#-----------------start----------------
x := foo
y := $(x) bar
x := later

$(warning -----y:$(y))
$(warning -----x:$(x))

y_02 := $(x_02) bar
x_02 := foo
$(warning -----y_02:$(y_02))
$(warning -----x_02:$(x_02))
#-----------------end----------------
```

输出：

```makefile
test.mk:6: -----y:foo bar
test.mk:7: -----x:later
test.mk:11: -----y_02: bar
test.mk:12: -----x_02:foo
```

***

# 问等于操作符–“?=”

变量没有被定义过，那么变量的值就直接赋值，如果变量先前被定义过，那么这条语将什么也不做；

示例1：

```makefile
FOO ?= bar
```
其含义是，如果FOO没有被定义过，那么变量FOO的值就是“bar”，如果FOO先前被定义过，那么这条语将什么也不做，其等价于：

```makefile
ifeq ($(origin FOO), undefined)
FOO = bar
endif
```
示例2：

```makefile
#-----------------start----------------
x ?= test
$(warning -----x:$(x))
x=hello
x ?= 100
$(warning -----x:$(x))
#-----------------end----------------
```

输出：
```makefile
test.mk:3: -----x:test
test.mk:6: -----x:hello
```

***

# 追加变量值–+=

使用“+=”操作符给变量追加值。

示例1：
```makefile
#-----------------start----------------
var=aaa bbb ccc
var+=ddd
$(warning -----var:$(var))
#-----------------end----------------
```

输出：
```makefile
test.mk:4: -----var:aaa bbb ccc ddd
```


***

# 判断 ifeq ifneq

ifeq 比较参数“arg1”和“arg2”的值是否相同，如果相同则为真。
```makefile
ifeq (<arg1>, <arg2> )
ifeq '<arg1>' '<arg2>'
ifeq "<arg1>" "<arg2>"
ifeq "<arg1>" '<arg2>'
ifeq '<arg1>' "<arg2>"
```
ifneq和ifeq类似：

```makefile
ifneq (<arg1>, <arg2> )
ifneq '<arg1>' '<arg2>'
ifneq "<arg1>" "<arg2>"
ifneq "<arg1>" '<arg2>'
ifneq '<arg1>' "<arg2>"
```

使用格式为：

```makefile
ifeq (arg1,arg2)
$(warning ----)
else
$(warning ----)
endif
```

```makefile
ifeq (arg1,arg2)
$(warning ----)
else ifeq (arg3,arg4)
$(warning ----)
endif
```

示例1：

如果定义LANIX_DATACON_ALERT为true，就内置LanixDataconAlert

```makefile
LANIX_DATACON_ALERT := true
ifeq ($(strip $(LANIX_DATACON_ALERT)),true)
  PRODUCT_PACKAGES += LanixDataconAlert 
endif
```

示例2：

如果定义PRODUCT_PREBUILT_WEBVIEWCHROMIUM为yes，就包含vendor/google/gms/apps/WebViewGoogle/overlay。
```makefile
PRODUCT_PREBUILT_WEBVIEWCHROMIUM := yes
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
PRODUCT_PACKAGES += WebViewGoogle
# The following framework overlay must be included if prebuilt WebViewGoogle.apk is used
PRODUCT_PACKAGE_OVERLAYS += vendor/google/gms/apps/WebViewGoogle/overlay
endif
```

示例3：

如果为eng版本就不内置SetupWizard，如果不为eng就内置SetupWizard。
```makefile
ifeq ($(strip $(TARGET_BUILD_VARIANT)),eng)
#$(warning ----eng---no--need---setupwizard----)
else
PRODUCT_PACKAGES += \
    SetupWizard
endif
```

示例4：

如果TARGET_USES_QTIC为空，就将TARGET_USES_QTIC置为true
```makefile
 ifeq ($(strip $(TARGET_USES_QTIC)),)
 TARGET_USES_QTIC := true
 endif
```


示例5：

如果PROJECT_NAME不为空，就复制对应vendor/(TARGETPRODUCT)/(TARGETPRODUCT)/(PROJECT_NAME)/copy_custom_files文件，如果PROJECT_NAME为空，就对应复制vendor/$(TARGET_PRODUCT)/trunk/copy_custom_files文件

```makefile
ifneq ($(strip $(PROJECT_NAME)),)
COPY_FILES_PATH := vendor/$(TARGET_PRODUCT)/$(PROJECT_NAME)/copy_custom_files
$(shell cp -rf  $(COPY_FILES_PATH)/*   .)
else
COPY_FILES_PATH := vendor/$(TARGET_PRODUCT)/trunk/copy_custom_files
$(shell cp -rf  $(COPY_FILES_PATH)/*   .)
endif
```

***

# ifdef ifndef

如果变量的值非空，那到表达式为真。否则，表达式为假。当然，同样可以是一个函数的返回值。


```makefile
ifdef <variable-name>
```
注意，ifdef只是测试一个变量是否有值，其并不会把变量扩展到当前位置。还是来看例子：


示例1：
```makefile
#-----------------start----------------
bar =
foo = $(bar)
ifdef foo
frobozz = yes
else
frobozz = no
endif
$(warning ----frobozz=$(frobozz))

foo =
ifdef foo
frobozz = yes
else
frobozz = no
endif
$(warning ----frobozz=$(frobozz))
#-----------------end----------------
```

输出：

```makefile
test.mk:9: ----frobozz=yes
test.mk:17: ----frobozz=no
```

示例2：

在*.c文件中定义：

```makefile
#ifndef WIFI_SDIO_IF_DRIVER_MODULE_PATH
#define WIFI_SDIO_IF_DRIVER_MODULE_PATH "/system/lib/modules/librasdioif.ko"
#endif
```

示例3：

在mk文件中：

```makefile
ifdef WIFI_DRIVER_MODULE_PATH
LOCAL_CFLAGS += -DWIFI_DRIVER_MODULE_PATH=\"$(WIFI_DRIVER_MODULE_PATH)\"
endif
```

***

# foreach 循环函数

```makefile
$(foreach <var>,<list>,<text> )
```

把参数中的单词逐一取出放到参数所指定的变量中，然后再执行所包含的表达式。每一次会返回一个字符串，循环过程中所返回的每个字符串会以空格分隔，最后当整个循环结束时，所返回的每个字符串所组成的整个字符串（以空格分隔）将会是foreach函数的返回值。

所以，最好是一个变量名，可以是一个表达式，而中一般会使用这个参数来依次枚举中的单词。

示例1：
```makefile
#-----------------start----------------
name:=a b c d
file:=$(foreach i,$(name),$(i).java)
$(warning -----file:$(file))
#-----------------end----------------
```

输出：
```makefile
test.mk:4: -----file:a.java b.java c.java d.java
```


***

# 文件复制 PRODUCT_COPY_FILES

复制文件到对应位置

示例1：

```makefile
PRODUCT_COPY_FILES += device/qcom/media/media_profiles_8916.xml:system/etc/media_profiles.xml \
device/qcom/media/media_codecs_8939.xml:system/etc/media_codecs_8939.xml \
device/qcom/media/media_codecs_8929.xml:system/etc/media_codecs_8929.xml
```

示例2：
对launcher应用app布局文件的定义：

```makefile
PRODUCT_COPY_FILES += vendor/packages/apks/default_workspace.xml:system/etc/default_workspace.xml
```

***

# 添加应用 PRODUCT_PACKAGES

示例1：
```makefile
PRODUCT_PACKAGES += \
    Phonesky \
    SetupWizard
```
***

# TARGET_BUILD_VARIANT编译类型（user ，userdebug，eng）

示例1：

```makefile
user_variant := $(filter user userdebug,$(TARGET_BUILD_VARIANT))
enable_target_debugging := true
tags_to_install :=
ifneq (,$(user_variant))
  # Target is secure in user builds.
  ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=1
  ADDITIONAL_DEFAULT_PROPERTIES += security.perf_harden=1

  ifeq ($(user_variant),user)
    ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
  endif

  ifeq ($(user_variant),userdebug)
    # Pick up some extra useful tools
    tags_to_install += debug
  else
    # Disable debugging in plain user builds.
    enable_target_debugging :=
  endif
```

示例2：
```makefile
#userdebug版本，才执行
ifneq ($(filter userdebug, $(TARGET_BUILD_VARIANT)),)
DEFINES += MTK_BUILD_DEFAULT_UNLOCK
endif
```


***
# all-subdir-makefiles

返回一个位于当前’my-dir’路径的子目录列表。


```makefile
include $(call all-subdir-makefiles)
```
例如，看下面的目录层次：

sources/foo/lib1/Android.mk

sources/foo/lib2/Android.mk

如果sources/foo/Android.mk包含一行：


```makefile
include $(call all-subdir-makefiles)
```

那么它就会自动包含sources/foo/lib1/Android.mk 和sources/foo/lib2/Android.mk
这项功能用于向编译系统提供深层次嵌套的代码目录层次。

注意：在默认情况下，NDK将会只搜索在sources/*/Android.mk中的文件。

***

# include $(CLEAR_VARS)

CLEAR_VARS 变量由Build System提供。并指向一个指定的GNU Makefile，由它负责清理很多LOCAL_xxx.
例如：LOCAL_MODULE, LOCAL_SRC_FILES, LOCAL_STATIC_LIBRARIES等等。但不清理LOCAL_PATH.

这个清理动作是必须的，因为所有的编译控制文件由同一个GNU Make解析和执行，其变量是全局的。所以清理后才能避免相互影响。

***

# TARGET_OUT

TARGET_OUT相当于out/target/product/l9010

```makefile
$(shell mkdir -p $(TARGET_OUT)/pre-install/CleanMaster_5.8.0/)
$(shell cp -af $(LOCAL_PATH)/CleanMaster_5.8.0.apk $(TARGET_OUT)/pre-install/CleanMaster_5.8.0/CleanMaster_5.8.0.apk)
```

mkdir的-p选项允许你一次性创建多层次的目录，而不是一次只创建单独的目录。
cp –af 源文件所在目录 放置文件夹

使用shell来内置应用中的库文件：

```makefile
$(shell mkdir -p  $(TARGET_OUT)/priv-app/$(LOCAL_MODULE)/lib/arm)
$(shell mkdir -p  $(TARGET_OUT)/priv-app/$(LOCAL_MODULE)/lib/arm64)
$(shell cp -rf $(LOCAL_PATH)/lib/arm/lib*.so $(TARGET_OUT)/priv-app/$(LOCAL_MODULE)/lib/arm/ )
$(shell cp -rf $(LOCAL_PATH)/lib/arm64/lib*.so $(TARGET_OUT)/priv-app/$(LOCAL_MODULE)/lib/arm64/ )
```

***

# 复制文件来覆盖对应的文件
```makefile
#cp custom files
$(shell cp -af  device/qcom/l9010/custom_files/bdroid_buildcfg.h  device/qcom/l9010/bdroid_buildcfg.h )
$(shell cp -af  device/qcom/l9010/custom_files/buildinfo.sh   build/tools/buildinfo.sh   )
$(shell cp -af  device/qcom/l9010/custom_files/external/sepolicy/keys.conf  external/sepolicy/keys.conf)
```

***

# 内置一个priv_app的应用

定义此app：

```makefile
amazon_appstore := true
ifeq ($(amazon_appstore), true)
include $(CLEAR_VARS)
LOCAL_MODULE := AmazonApps-release_v16.0000.887.13C
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_PRIVILEGED_MODULE := true
include $(BUILD_PREBUILT)
endif
```

将其内置进去：
```makefile
PRODUCT_COPY_FILES += vendor/tinno/blu/3rd_app/amazon_appstore/amzn.apps.ref:system/etc/amzn.apps.ref
PRODUCT_COPY_FILES += vendor/tinno/blu/3rd_app/amazon_appstore/liblatency.so:system/lib/liblatency.so
PRODUCT_PACKAGES += \
    AmazonApps-release_v16.0000.887.13C \
```

***

# call —声明一个mk文件

声明mk文件，把mk中的变量添加进来
```makefile
BOOTANIMATION_RES := true
ifeq ($(BOOTANIMATION_RES), true)
$(call inherit-product, device/qcom/l9010/res/shutdown/shut.mk)
$(call inherit-product, device/qcom/l9010/res/animation/animation.mk)
endif
```

如果mk文件存在，就调用mk文件：

```makefile
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)
```

***

# include mk文件

```makefile
include $(LOCAL_PATH)/models/Android.mk
#Config product info
-include device/eastaeon/$(MTK_TARGET_PROJECT)/configs/*.mk
```

***

# PRODUCT_PROPERTY_OVERRIDES–系统属性值的覆盖

```makefile
PRODUCT_PROPERTY_OVERRIDES += \
       dalvik.vm.heapgrowthlimit=128m \
       dalvik.vm.heapminfree=6m \
       dalvik.vm.heapstartsize=14m
```

***

# override 指示符

如果有变量是通常make的命令行参数设置的，那么Makefile中对这个变量的赋值会被忽略。如果你想在Makefile中设置这类参数的值，那么，你可以使用“override”指示符。

其语法是：

```makefile
override <variable> = <value>
override <variable> := <value>
override <variable> += <more text>
```

./build/kati/testcase/override_define.mk
```makefile
override CC := gcc
override  AS = as
```

示例1：
```makefile
#-----------------start----------------
$(warning -----var_01:$(var_01))
var_01 = test_01
$(warning -----var_01:$(var_01))
override var_01 = test_01
$(warning -----var_01:$(var_01))
#-----------------end----------------
```

编译命令：

```makefile
make var_01=test   -f test.mk 
```

输出：
```makefile
test.mk:2: -----var_01:test
test.mk:4: -----var_01:test
test.mk:6: -----var_01:test_01
```


***

# PLATFORM平台
芯片平台，是MTK,还是QCOM

```makefile
ifneq ((strip(strip(PLATFORM)), QCOM)
PRODUCT_PACKAGES += XXX
endif
```

***

# LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES 配置jar包到项目中

可以参考---packages\apps\CMFileManager\Android.mk

内置一个ireadygo_keyadapter.jar到应用中。
(1)新建libs文件，将ireadygo_keyadapter.jar添加到libs文件中
(2)在Android.mk文件中添加：

```makefile

LOCAL_STATIC_JAVA_LIBRARIES += ireadygo_keyadapter
.....................................................
include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    ireadygo_keyadapter:libs/ireadygo_keyadapter.jar

include $(BUILD_MULTI_PREBUILT)
include $(call all-makefiles-under,$(LOCAL_PATH))
```

***

```makefile

```

***


# 常用make命令

```makefile
编译各个模块
make systemimage
make kernel
make clean
make otapackage

编译selinux:
make sepolicy -j16
mmm system/sepolicy

强制生成system.img文件
make snod
```

***

```makefile

```