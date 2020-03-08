# openssl-for-android

[![Build Status](https://img.shields.io/travis/com/alvisisme/android-openssl?style=flat-square)](https://travis-ci.com/alvisisme/android-openssl)

编译openssl至android平台arm64-v8a架构。

本工程仅编译openssl静态库。

## 目录

- [背景](#背景)
- [安装](#安装)
- [用法](#用法)
- [维护人员](#维护人员)
- [贡献参与](#贡献参与)
- [许可](#许可)
- [参考引用](#参考引用)

## 背景

编译环境

* ubuntu18.04
* android-ndk-r13b
* openssl-1.0.2g

## 安装

将**dist**目录下对应头文件和库文件引入。

## 用法

推荐使用 docker 和 docker-compose 进行编译

```bash
docker-compose up --build
```

编译后的文件位于 **build/lib** 目录下

## 维护人员

[@Alvis Zhao](https://github.com/alvisisme)

## 贡献参与

欢迎提交PR。

## 许可

© 2020 Alvis Zhao

## 参考资料

* [wiki.openssl.org](https://wiki.openssl.org/index.php/Android)
* [Adding OpenSSL Support for Android](http://doc.qt.io/qt-5/opensslsupport.html)
