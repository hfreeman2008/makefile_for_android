# makefile_for_android

这篇文章主要是一个对于android开发时常用的makefile(mk)笔记。



# 打印log

```makefile
$(error  " test   $(is-vendor-board-platform)")
$(error  " test   0001")
$(warning $(TARGET_ARCH))  
$(info test,hehe)  
```



