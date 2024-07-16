# makefile_for_android

这篇文章主要是一个对于android开发时常用的makefile(mk)笔记。


![甜美](甜美.png)

***

# 打印log

```makefile
$(error  " test   $(is-vendor-board-platform)")
$(error  " test   0001")
$(warning $(TARGET_ARCH))  
$(info test,hehe)  
```

***

# make方法


## 指定编译文件

指定特定的Makefile，你可以使用make的“-f”和“–file”参数.

```makefile
make -f Make.Linux
make –file Make.AIX
make -f test.mk
```

GNU make找寻默认的Makefile的规则是在当前目录下依次找三个文件–“GNUmakefile”，“makefile”和“Makefile”。

其按顺序找这三个文件，一旦找到，就开始读取这个文件并执行。



***

## make的退出码
make命令执行后有三个退出码：

0 —— 表示成功执行。

1 —— 如果make运行时出现任何错误，其返回1。

2 —— 如果你使用了make的“-q”选项，并且make使得一些目标不需要更新，那么返回2。


***

## make的参数

```makefile
make -h
用法：make [选项] [目标] ...
选项：
  -b, -m                      忽略兼容性。
  -B, --always-make           Unconditionally make all targets.
  -C 目录, --directory=目录
                              在所有操作前切换到“目录”。
  -d                          打印大量调试信息。
  --debug[=FLAGS]             打印各种调试信息
  -e, --environment-overrides
                              指定替代makefile中默认设置的环境变量
  -f FILE, --file=FILE, --makefile=FILE
                              读取 FILE 作为一个 makefile.
  -h, --help                  打印该消息并退出。
  -i, --ignore-errors         Ignore errors from commands.
  -I DIRECTORY, --include-dir=DIRECTORY
                              搜索 DIRECTORY 为包含的 makefiles.
  -j [N], --jobs[=N]          同时允许 N 个任务；无参数表明允许无限个任务。
  -k, --keep-going            当某些目标无法创建时仍然继续。
  -l [N], --load-average[=N], --max-load[=N]
                              不开始多线程工作除非系统负载低于N
  -L, --check-symlink-times   Use the latest mtime between symlinks and target.
  -n, --just-print, --dry-run, --recon
                              不要实际运行任何命令;仅仅输出他们
  -o FILE, --old-file=FILE, --assume-old=FILE
                              将FILE认作非常老,不要重新make它.
  -p, --print-data-base       打印 make 的内部数据库。
  -q, --question               不运行任何命令；退出状态说明是否已全部更新。
  -r, --no-builtin-rules      禁用内置隐含规则。
  -R, --no-builtin-variables   禁用内置变量设置。
  -s, --silent, --quiet       不显示命令。
  -S, --no-keep-going, --stop
                              关闭 -k.
  -t, --touch                 touch 目标而不是重新创建它们
  -v, --version               打印 make 的版本号并退出。
  -w, --print-directory       打印当前目录。
  --no-print-directory        即使 -w 隐式开启，也要关闭 -w。
  -W FILE, --what-if=FILE, --new-file=FILE, --assume-new=FILE
                              将FILE认作无限新.
  --warn-undefined-variables  Warn when an undefined variable is referenced.

这个程序创建为 i686-pc-linux-gnu
Report bugs to <bug-make@gnu.org>
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

# 变量

## 自定义变量

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

## 冒号等于操作符–”:=“

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

## 问等于操作符–“?=”

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

## 追加变量值–+=

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

## export-传参

同一个进程

```makefile
export EX_VAR = value
export EX_VAR := value
export EX_VAR += value
```


注意：是同一个进程下的make才有用。当多级遍历make时是无法全局的。

***

## PRODUCT_PACKAGES-添加应用

示例1：
```makefile
PRODUCT_PACKAGES += \
    Phonesky \
    SetupWizard
```


***


# ifeq ifneq-判断

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

# ifdef ifndef-是否定义

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

# foreach-循环函数

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

# PRODUCT_COPY_FILES-文件复制

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


# 特殊变量


## TARGET_BUILD_VARIANT-编译类型user,userdebug,eng

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

## TARGET_OUT

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


## PLATFORM-平台
芯片平台，是MTK,还是QCOM

```makefile
ifneq ((strip(strip(PLATFORM)), QCOM)
PRODUCT_PACKAGES += XXX
endif
```

***


## TARGET_PRODUCT-项目名变量

这个就是lunch时选择项目的名字

```makefile
$(call inherit-product,device/xthink/$(TARGET_PRODUCT)/$(TARGET_PRODUCT)/sounds/sounds.mk)
```

```makefile
ifeq ($(TARGET_PRODUCT),VIA_A4)
PRODUCT_PACKAGES += GoogleDialer
PRODUCT_PACKAGES += DeskClockGoogle
endif
```

***

## ANDROID_BUILD_TOP-android目录所在的路径

这表示代码的android目录所在的路径

示例1:
```makefile
DIR=$ANDROID_BUILD_TOP/external/libphonenumber
```

示例2:
```makefile
if [ -z "$ANDROID_BUILD_TOP" ]; then
    echo "Missing environment variables. Did you run build/envsetup.sh and lunch?" 1>&2
    exit 1
fi
```

示例3:
```makefile
source ${ANDROID_BUILD_TOP}/build/envsetup.sh
```

***

## LOCAL_PATH-路径名

```makefile
LOCAL_PATH := device/xthink/N30/N30/sounds
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/ringtones/Aquila.ogg:system/media/audio/ringtones/Aquila.ogg \
```


```makefile
LOCAL_PATH:= $(call my-dir)
```

每个Android.mk文件必须以定义LOCAL_PATH为开始。它用于在开发tree中查找源文件。

宏my-dir 则由Build System提供。

返回包含Android.mk的目录路径，这个路径非常有用。


***

## override-指示符

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

# call—声明一个mk文件

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

# include-mk文件

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

# LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES-配置jar包到项目中

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

# LOCAL_PREBUILT_JNI_LIBS-复制内置apk中的so文件

```makefile
LOCAL_PREBUILT_JNI_LIBS:= \
         @lib/armeabi/libnativeU.so
```

```makefile
LOCAL_PREBUILT_JNI_LIBS := \
    @lib/$(my_src_abi)/libbitmap_parcel.so \
    @lib/$(my_src_abi)/librectifier.so \
    @lib/$(my_src_abi)/libwebp_android.so
```


***

# LOCAL_OVERRIDES_PACKAGES-替换app

用当前app替换Gallery2

```makefile
LOCAL_OVERRIDES_PACKAGES := Gallery2
```

***

# LOCAL_CERTIFICATE-platform签名


```makefile
LOCAL_PACKAGE_NAME := Settings
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
```

LOCAL_PACKAGE_NAME := Settings
app应用的名称

LOCAL_CERTIFICATE := platform
代表使用platform来签名，这样的话这个apk就拥有了和system相同的签名，这需要在androidmanifest.xml文件中添加android:sharedUserId=”android.uid.system”，使得apk有system权限。

LOCAL_PRIVILEGED_MODULE := true
app应用在目录/system/priv-app/下

LOCAL_PRIVILEGED_MODULE := false
app应用在目录/system/app/下

***

# 使用函数

在Makefile中可以使用函数来处理变量，从而让我们的命令或是规则更为的灵活和具有智能。make所支持的函数也不算很多，不过已经足够我们的操作了。函数调用后，函数的返回值可以当做变量来使用。
函数调用，很像变量的使用，也是以“$”来标识的.

语法如下：

```makefile
$(<function> <arguments> )
${<function> <arguments>}
```

函数名，make支持的函数不多。是函数的参数，参数间以逗号“,”分隔，而函数名和参数之间以“空格”分隔。函数调用以“”开头，以圆括号或花括号把函数名和参数括起。感觉很像一个变量，是不是？函数中的参数可以使用变量，为了风格的统一，函数和变量的括号最好一样，如使用“”开头，以圆括号或花括号把函数名和参数括起。感觉很像一个变量，是不是？函数中的参数可以使用变量，为了风格的统一，函数和变量的括号最好一样，如使用“(subst a,b,(x))”这样的形式，而不是“(x))”这样的形式，而不是“(subst a,b,${x})”的形式。因为统一会更清楚，也会减少一些不必要的麻烦。

***

## filter filter-out 

过滤函数和反过滤函数

- filter

```makefile
$(filter word1 word2,$(VARIANTS))
```

判断变量VARIANTS中是否包含word1和 word2，如果包含就把VARIANTS中包含的word1和word2之外的过滤掉

示例：

```makefile
VARIANTS := mon tue wed thu fri sat sun
DAY := $(filter sat sun,$(VARIANTS))
$(info $(DAY))
```

输出：

sat sun

- filter-out

```makefile
$(filter-out word1 word2,$(VARIANTS))
```
判断变量VARIANTS中是否包含word1和 word2，如果包含就把VARIANTS中包含的word1和word2过滤掉，其余的全部保留

示例：

```makefile
VARIANTS := mon tue wed thu fri sat sun
DAY := $(filter-out sat sun,$(VARIANTS))
$(info $(DAY))
```

输出为：

mon tue wed thu fri

***

## strip-去空格函数

功能：去掉字串中开头和结尾的空字符。

返回：返回被去掉空格的字符串值。

```makefile
$(strip string)
```

示例1:

```makefile
TEST = DEFAULT 
RESULT = no

ifeq ($(strip $(TEST)), DEFAULT)
    RESULT = yes
endif
```

示例2:

```makefile
my_value = hello
$(warning ----my_value:$(strip $(my_value)))
```

输出：

test.mk:3: ----my_value:hello

示例3:

```makefile
$(strip a b c )
```

把字串“a b c ”去到开头和结尾的空格，结果是“a b c”。

示例4:

```makefile
#-----------------start----------------
my_value_01 = hello_1
my_value_02 = hello_2
my_value_03 = hello_3

$(warning ----:$(strip $(my_value_01) $(my_value_02) $(my_value_03)))
#-----------------end----------------
```

输出：

test.mk:6: ----:hello_1 hello_2 hello_3

***
## findstring–查找字符串函数

功能：从string_Src中查找string_a

返回：如果查找到string_a，返回string_a，如果没有查找到，返回

```makefile
findstring string_a, string_Src
```

示例1:

```makefile
#-----------------start----------------
$(warning ----$(findstring a,a b c))
$(warning ----$(findstring a,b c))
#-----------------end----------------
```
输出：
```makefile
test.mk:2: ----a
test.mk:3: ----
```

示例2:

```makefile
WIKO_SOUND_VERSION:=wiko_sound_1_3

ifneq ($(strip $(WIKO_SOUND_VERSION)),)
$(warning $(WIKO_SOUND_VERSION))
ifeq ($(findstring _1_0, $(strip $(WIKO_SOUND_VERSION))),_1_0)
......
else ifeq ($(findstring _1_1, $(strip $(WIKO_SOUND_VERSION))),_1_1)
```

***

## subst-字符串替换

名称：字符串替换函数——subst。

功能：把字串中的字符串替换成。

返回：函数返回被替换过后的字符串。

```makefile
$(subst <from>,<to>,<text> )
```

示例1:
```makefile
#-----------------start----------------
$(warning ----$(subst o,e,football))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: ----feetball
```

***

## patsubst–模式字符串替换函数
功能：查找中的单词（单词以“空格”、“Tab”或“回车”“换行”分隔）是否符合模式，如果匹配的话，则以替换。

这里，可以包括通配符“%”，表示任意长度的字串。如果中也包含“%”，那么，中的这个“%”将是中的那个“%”所代表的字串。（可以用“\”来转义，以“\%”来表示真实含义的“%”字符）

返回：函数返回被替换过后的字符串。
```makefile
$(patsubst <pattern>,<replacement>,<text> )
```


示例1:
```makefile
#-----------------start----------------
$(warning ----$(patsubst %.c,%.o,x.c.c bar.c)))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: ----x.c.o bar.o
```


***

## sort–排序函数
功能：给字符串中的单词排序（升序）。

返回：返回排序后的字符串。

备注：sort函数会去掉中相同的单词。

```makefile
$(sort <list> )
```

示例1:

```makefile
#-----------------start----------------
$(warning ----$(sort foo bar lose))
$(warning ----$(sort foo bar bar lose))
#-----------------end----------------
```

输出：

```makefile
test.mk:2: ----bar foo lose
test.mk:3: ----bar foo lose
```


***

## word–取单词函数

功能：取字符串中第个单词。（从一开始）

返回：返回字符串中第个单词。如果比中的单词数要大，那么返回空

```makefile
$(word <n>,<text> )
```

示例1:

```makefile
#-----------------start----------------
$(warning ----$(word 1, foo bar baz))
#-----------------end----------------
```

输出：

```makefile
test.mk:2: ----foo
```

***

## wordlist–取单词串函数
功能：从字符串中取从开始到结束的单词串。

返回：返回字符串中从到的单词字串。如果比中的单词数要大，那么返回空字符串。如果大于的单词数，那么返回从开始，到结束的单词串。

```makefile
$(wordlist <s>,<e>,<text> )
```

示例1:
```makefile
#-----------------start----------------
$(warning ----$(wordlist 2, 3, foo bar2 bar3))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: ----bar2 bar3
```

***

## words–单词个数统计函数

功能：统计中字符串中的单词个数。

返回：返回中的单词数。

备注：如果我们要取中最后的一个单词，我们可以这样：(word(word(words), )。
```makefile
$(words <text> )
```

示例1:

```makefile
#-----------------start----------------
string = foo bar baz
$(warning ----$(words $(string)))
$(warning ----$(word $(words $(string)),$(string)))
#-----------------end----------------
```

输出：
```makefile
test.mk:3: ----3
test.mk:4: ----baz
```


***
## firstword–首单词函数

功能：取字符串中的第一个单词。

返回：返回字符串的第一个单词。
```makefile
$(firstword <text> )
```

示例1:
```makefile
#-----------------start----------------
string = foo bar baz
$(warning ----$(firstword  $(string)))
#-----------------end----------------
```


输出：
```makefile
test.mk:3: ----foo
```

***

## dir-取目录函数
功能：从文件名序列中取出目录部分。目录部分是指最后一个反斜杠（“/”）之前的部分。如果没有反斜杠，那么返回“./”。

返回：返回文件名序列的目录部分。

示例： $(dir src/foo.c hacks)返回值是“src/ ./”。

```makefile
$(dir <names...> )
```


示例1:

```makefile
#-----------------start----------------
$(warning -----dir:$(dir src/hellp.java test.sh))
#-----------------end----------------
```

输出：
```makefile
$(addsuffix <suffix>,<names...> )
test.mk:3: -----dir:src/ ./
```


***
## notdir-取文件函数

功能：从文件名序列中取出非目录部分。非目录部分是指最后一个反斜杠（“/”）之后的部分。

返回：返回文件名序列的非目录部分。
```makefile
$(notdir <names...> )
```

示例1:
```makefile
#-----------------start----------------
$(warning -----notdir:$(notdir src/hellp.java test.sh))
#-----------------end----------------
```

输出：
```makefile
test.mk:2: -----notdir:hellp.java test.sh
```
***

## suffix-取后缀函数
功能：从文件名序列中取出各个文件名的后缀。

返回：返回文件名序列的后缀序列，如果文件没有后缀，则返回空字串。

```makefile
$(suffix <names...> )
```

示例1:
```makefile
#-----------------start----------------
$(warning -----suffix:$(suffix src/hellp.java test.sh))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: -----suffix:.java .sh
```


***
## basename-取前缀函数
功能：从文件名序列中取出各个文件名的前缀部分。

返回：返回文件名序列的前缀序列，如果文件没有前缀，则返回空字串。
```makefile
$(basename <names...> )
```

示例1:
```makefile
#-----------------start----------------
$(warning -----basename:$(basename src/hellp.java test.sh))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: -----basename:src/hellp test
```


***

## addsuffix-加后缀函数

功能：把后缀加到中的每个单词后面。

返回：返回加过后缀的文件名序列。

```makefile
$(addsuffix <suffix>,<names...> )
```

示例1:
```makefile
#-----------------start----------------
$(warning -----addsuffix:$(addsuffix .java, src/hellp test))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: -----addsuffix:src/hellp.java test.java
```

***

## addprefix-加前缀函数

功能：把前缀加到中的每个单词后面。

返回：返回加过前缀的文件名序列。
```makefile
$(addprefix <prefix>,<names...> )
```

示例1:
```makefile
#-----------------start----------------
$(warning -----addprefix:$(addprefix src/, hellp.java test.java))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: -----addprefix:src/hellp.java src/test.java
```


***

## join-连接函数
功能：把中的单词对应地加到的单词后面。

返回：返回连接过后的字符串。

```makefile
$(join <list1>,<list2> )
```

示例1:
```makefile
#-----------------start----------------
$(warning -----join:$(join aaa, b))
$(warning -----join:$(join a, bbb))

$(warning -----join:$(join aaabbb,1112222333444))
#-----------------end----------------
```


输出：
```makefile
test.mk:2: -----join:aaab
test.mk:3: -----join:abbb
test.mk:5: -----join:aaabbb1112222333444
```

***
## call函数
call函数是唯一一个可以用来创建新的参数化的函数。

你可以写一个非常复杂的表达式，这个表达式中，你可以定义许多参数，然后你可以用call函数来向这个表达式传递参数。

其语法是：

```makefile
$(call <expression>,<parm1>,<parm2>,<parm3>...)
```

当 make执行这个函数时，参数中的变量，如(1)，(1)，(2)，$(3)等，会被参数，，依次取代。而的返回值就是 call函数的返回值。

示例1:

```makefile
#-----------------start----------------
reverse=$(1)$(2)
result=$(call reverse,a,b)
$(warning -----result:$(result))
#-----------------end----------------
```

输出：

```makefile
test.mk:4: -----result:ab
```

***

## xy_product_copy_files-复制文件的方法

定义一个专门复制文件的方法xy_product_copy_files，再将文件复现到设备的位置，也就是out目录下：

在mk文件中，将配置文件复制对应位置 

```makefile
##add hexiaoming xy_auto modify android version 10.0 (for third apk) 20220414 start
$(call xy_product_copy_files,device/mediatek/ac8227l/andsdk_third_app_white_list_xyauto.conf,system/etc/xy,andsdk_third_app_white_list_xyauto.conf)
##add hexiaoming xy_auto modify android version 10.0 (for third apk) 20220414 end
```


在mk中，实现xy_product_copy_files方法

```makefile
####################cust define fuction################
define xy_product_copy_files
$(shell  mkdir -p  out/target/product/$(XY_PLATFORM)/$(2) ; \
         cp  -rf $(1)  out/target/product/$(XY_PLATFORM)/$(2)/$(3) ;)
endef
```


***

## wildcard-扩展通配符
示例1:
```makefile
$(info "wildcard test002----:$(wildcard test002)")
$(info "wildcard test.mk----:$(wildcard test.mk)")
```

输出:
```makefile
"wildcard test002----:test002"
"wildcard test.mk----:test.mk"
```

示例2:

判断文件是否存在：

匹配是否有include/config.mk这个文件，如果没有的话会返回空，这个ifeq就会成立，也就会输出错误。

```makefile
ifeq ($(wildcard include/config.mk),)
$(error "System not configured - see README")
endif
```

示例3:

判断目录是否存在：

```makefile
ifeq ($(wildcard test002),)
$(info "0001---if---test002")
else
$(info "0002---else---test002")
endif
```

输出:
```makefile
"0002---else---test002"
```


示例4:

wildcard 用来明确表示通配符

```makefile
$(wildcard os/cpu/$(CPU)/inc/cpu/*.h)
```


***


# shell函数

shell 函数也不像其它的函数，它的参数应该就是操作系统Shell的命令。

它和反引号“`”是相同的功能。shell函数把执行操作系统命令后的输出作为函数返回。

于是，我们可以用操作系统命令以及字符串处理命令awk，sed等等命令来生成一个变量。

示例1:
```makefile
#-----------------start----------------
result=$(shell cat test.mk)
$(warning -----result:$(result))
result=$(shell echo *.mk)
$(warning -----result:$(result))
#-----------------end----------------
```

输出：
```makefile
test.mk:3: -----result:#-----------------start---------------- result=$(shell cat test.mk) $(warning -----result:$(result)) result=$(shell echo *.mk) $(warning -----result:$(result)) #-----------------end----------------
test.mk:5: -----result:test _02.mk test.mk
```


注意，这个函数会新生成一个Shell程序来执行命令，所以你要注意其运行性能，如果你的Makefile中有一些比较复杂的规则，并大量使用了这个函数，那么对于你的系统性能是有害的。

特别是Makefile的隐晦的规则可能会让你的shell函数执行的次数比你想像的多得多。

示例2:
执行shell命令，如git checkout:

```makefile
$(warning  "XY_AUTO_BUILD_GREEN_VERSION= $(XY_AUTO_BUILD_GREEN_VERSION)")
ifeq ($(strip $(XY_AUTO_BUILD_GREEN_VERSION)), yes)
   $(shell  git checkout  ./vendor/mediatek/proprietary/bootable/bootloader/lk/dev/logo/cmcc_1024x600/cmcc_1024x600_kernel.bmp ;)
   $(shell  git checkout  ./vendor/mediatek/proprietary/bootable/bootloader/lk/dev/logo/cmcc_1024x600/cmcc_1024x600_uboot.bmp ;)
   $(shell  git checkout  ./vendor/mediatek/proprietary/packages/3rd-party/bootanimation/ ;)
endif
```
示例3:
执行sh脚本：

```makefile
ifeq ($(strip $(ASSISTANT_BOARD)),TXZ_EN)
 $(shell ./vendor/mediatek/proprietary/packages/3rd-party/voice_txz/push_txz_xyauto.sh $(XY_PLATFORM) 1 )
else ifeq ($(strip $(ASSISTANT_BOARD)),TXZ_VI)
 $(shell ./vendor/mediatek/proprietary/packages/3rd-party/voice_txz/push_txz_xyauto.sh $(XY_PLATFORM) 2 )
endif
```
示例4:
执行常见的shell命令

```makefile
$(shell sed -i "/ZLINK_SUPPORT/c #define ZLINK_SUPPORT 0" kernel-3.18/include/linux/adau1701config.h )
ifeq ($(strip $(ZLINK_SUPPORT)), true)
   $(shell sed -i "/ZLINK_SUPPORT/c #define ZLINK_SUPPORT 1" kernel-3.18/include/linux/adau1701config.h )
endif
$(shell  cp -f  device/mediatek/common/fmradio/tda7729xycfg_open.h   kernel-3.18/sound/soc/codecs/tda7729xycfg.h ;)
```


***


## 复制文件来覆盖对应的文件
```makefile
#cp custom files
$(shell cp -af  device/qcom/l9010/custom_files/bdroid_buildcfg.h  device/qcom/l9010/bdroid_buildcfg.h )
$(shell cp -af  device/qcom/l9010/custom_files/buildinfo.sh   build/tools/buildinfo.sh   )
$(shell cp -af  device/qcom/l9010/custom_files/external/sepolicy/keys.conf  external/sepolicy/keys.conf)
```



***



## 判断文件或文件夹是否存在

Android.mk 推断文件是否存在，若存在则复制该文件到某个文件夹


```makefile
$(shell test -f [文件] && echo yes)的值假设是yes, 则文件存在，然后进行shell cp 动作

HAVE_TEST_CUST_FILE := $(shell test -f vendor/huaqin/resource/$(HQ_PROJECT)_$(HQ_CLIENT)/$(LOCAL_PATH)/DroidSansFallback.ttf && echo yes)
ifeq ($(HAVE_TEST_CUST_FILE),yes)
$(shell cp -f vendor/resource/$(HQ_PROJECT)_$(HQ_CLIENT)/$(LOCAL_PATH)/DroidSansFallback.ttf $(PRODUCT_OUT)/system/fonts/DroidSansFallback.ttf)
endif
```

文件描述符
```makefile
-e 判断对象是否存在
-d 判断对象是否存在，并且为目录
-f 判断对象是否存在，并且为常规文件
-L 判断对象是否存在，并且为符号链接
-h 判断对象是否存在，并且为软链接
-s 判断对象是否存在，并且长度不为0
-r 判断对象是否存在，并且可读
-w 判断对象是否存在，并且可写
-x 判断对象是否存在，并且可执行
-O 判断对象是否存在，并且属于当前用户
-G 判断对象是否存在，并且属于当前用户组
-nt 判断file1是否比file2新  [ "/data/file1" -nt "/data/file2" ]
-ot 判断file1是否比file2旧  [ "/data/file1" -ot "/data/file2" ]
```




***


# c文件添加开关

在Android.mk文件中添加开关的定义：
```makefile
#ifneq ($(filter userdebug eng,$(TARGET_BUILD_VARIANT)),)
LOCAL_CFLAGS += -DBD_ADDR_AUTOGEN
#endif
```


在.c文件中进行使用：
```makefile
#ifdef BD_ADDR_AUTOGEN
GetRandomValue(btinit->bt_nvram.fields.addr);
#endif
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


# 参考资料
1.https://blog.csdn.net/hfreeman2008/article/details/46792693

android开发笔记之mk文件

2.https://blog.csdn.net/hfreeman2008/article/details/71418693

android开发笔记之Makefile（一）

***

[<font face='黑体' color=#ff0000 size=40 >跳转到文章开始</font>](#makefile_for_android)