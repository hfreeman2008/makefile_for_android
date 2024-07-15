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