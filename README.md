<div align="center">
    <h1>UDE-All-In-One-Flutter</h1>
</div>

## 前言
### FlutterSDK
在Ubutu中安装FlutterSDK，并配置桌面开发与安卓开发工具链，如果仅进行桌面与网页开发，配置较为简单快捷，但如果要进行安卓开发，所需工具链较为复杂，虽然脚本会自动执行配置，但是想在此略作简介，以便可以更好的理解或者出现错误后可以检查，首先Flutter应用的开发仅依赖FlutterSDK，不依赖其他
### 桌面开发工具链
桌面或网页应用的构建依赖clang cmake libgtk-3-dev ninja-build pkg-config liblzma-dev libstdc++-12-dev，在ubuntu中可以使用apt包管理器快速获取
### 安卓开发工具链
安卓应用的构建依赖gradle，而gradle依赖于JDK与Android SDK，最少包括cmdline-tools;latest，build-tools;35.0.1，platform-tools，platforms;android-35，这些工具链以及gradle仓库不少与Google有关，所以在中国安装有时会碰到问题，笔者尝试配置过镜像源，但版本不对应，依赖不全等问题时有发生，所以为稳定性考虑，此脚本并不提供镜像源的配置，涉及AndroidSDK的安装以及gradle构建时的下载如果出现网络问题，请使用代理
### 警告
脚本仅为初级版本，对于错误的处理与重试机制不够完善，所以谨慎使用，也欢迎大家提出建议乃至帮忙更改
## 使用方法
- 下载对应版本的FlutterSDK安装脚本，在终端中运行

~~~
sudo bash flutter3.29.3.sh
~~~

- 选择是否配置桌面与网页开发工具链
- 选择是否配置安卓开发工具链
- 如果要配置安卓开发工具链，需要接受Adroid许可
- 安装完成后执行以下命令使环境配置生效(bashrc替换为你的默认终端，如zshrc)

~~~
source ~/.bashrc
~~~

- 如果要卸载Flutter开发环境，请下载uninstall.sh并在终端中执行

~~~
sudo bash uninstall.sh
~~~

## 特别提醒
- 安装脚本在配置安卓开发工具链时会试图安装JAVA 17，如系统中已存在或想使用其他版本的JAVA，请拒绝此选项
- 该脚本环境变量的相关配置默认写入~/.bashrc，如果您的默认终端并非bash，请打开该脚本文件修改TERMINAL_RC为您默认终端的配置文件，例如使用zsh作为默认终端，应做如下修改，卸载时也应当在uninstall.sh的对应位置修改

~~~
TERMINAL_RC="{$HOME}/.zshrc"
~~~
