# UDE-All-In-One-Flutter
## 前言
在Ubutu中安装FlutterSDK，并配置桌面开发与安卓开发工具链
## 使用方法
下载对应版本的FlutterSDK安装脚本，在终端中运行

~~~
sudo bash flutter3.29.3.sh
~~~

## 特别提醒
- 安装脚本在配置安卓开发工具链时会试图安装JAVA 17，如系统中已存在或想使用其他版本的JAVA，请拒绝此选项
- 该脚本环境变量的相关配置默认写入~/.bashrc，如果您的默认终端并非bash，你打开该脚本文件修改TERMINAL_RC为您默认终端的配置文件，例如使用zsh作为默认终端，应做如下修改
~~~
TERMINAL_RC="{$HOME}/.zshrc"
~~~
