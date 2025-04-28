#!/bin/bash
set -euo pipefail
# 全局配置
readonly FLUTTER_VERSION="3.29.3"
readonly FLUTTER_DIR="${HOME}/Flutter/FlutterSDK"
readonly TERMINAL_RC="${HOME}/.bashrc"
# 下载comline-tools的url，可根据镜像源与版本修改
readonly CMDLINE_TOOLS="https://mirrors.cloud.tencent.com/AndroidSDK/commandlinetools-linux-13114758_latest.zip"

# 颜色定义
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

# 先决条件检查
check_dependency() {
    # 定义需要检查的命令数组
    required_commands=(wget unzip)
    missing_commands=()

    # 遍历检查所有命令
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &>/dev/null; then
            missing_commands+=("$cmd")
        fi
    done

    # 统一处理缺失命令
    if [ ${#missing_commands[@]} -gt 0 ]; then
        echo -e "${RED}错误：缺失以下依赖工具：${missing_commands[*]}${NC}"
        echo "请执行安装命令：sudo apt install ${missing_commands[*]}"
        exit 1
    fi
}

# Flutter安装配置
install_flutter() {

    # 临时配置环境变量以便下载
    export PUB_HOSTED_URL="https://pub.flutter-io.cn"
    export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
    echo -e "${GREEN}正在下载Flutter SDK $FLUTTER_VERSION...${NC}"
    local flutter_url="https://storage.flutter-io.cn/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
    mkdir -p "$FLUTTER_DIR"
    wget "$flutter_url" -O - | tar xJ -C "$FLUTTER_DIR" --strip-components=1

    echo -e "${GREEN}配置环境变量到 $TERMINAL_RC...${NC}"
    # 检查并添加PUB_HOSTED_URL
    if ! grep -qF "export PUB_HOSTED_URL=\"https://pub.flutter-io.cn\"" "$TERMINAL_RC"; then
        echo -e "export PUB_HOSTED_URL=\"https://pub.flutter-io.cn\"" >> "$TERMINAL_RC"
    fi
    # 检查并添加FLUTTER_STORAGE_BASE_URL
    if ! grep -qF "export FLUTTER_STORAGE_BASE_URL=\"https://storage.flutter-io.cn\"" "$TERMINAL_RC"; then
        echo -e "export FLUTTER_STORAGE_BASE_URL=\"https://storage.flutter-io.cn\"" >> "$TERMINAL_RC"
    fi
    # 检查并添加PATH
    if ! grep -qF "export PATH=\"${FLUTTER_DIR}/bin:\$PATH\"" "$TERMINAL_RC"; then
        echo -e "export PATH=\"${FLUTTER_DIR}/bin:\$PATH\"" >> "$TERMINAL_RC"
    fi

    echo -e "${GREEN}FlutterSDK安装完成,正在清理安装包...${NC}"
}

# 桌面开发工具链
install_desktop_toolchain() {
    echo -ne "${GREEN}是否配置桌面与网页开发工具链? (y/N):${NC}"
    read -r choice
    case "$choice" in 
      [yY])
        echo -e "${GREEN}正在配置桌面与网页开发工具链...${NC}"
        sudo apt update
        sudo apt install -y clang cmake libgtk-3-dev ninja-build pkg-config liblzma-dev libstdc++-12-dev
        ;;
      *)
        echo -e "${RED}已跳过桌面开发工具链配置,可通过flutter doctor检查工具链完整性"
        ;;
    esac
}

# 安卓开发工具链
install_android_toolchain() {
    echo -ne "${GREEN}是否配置安卓开发工具链? (y/N):${NC}"
    read -r choice
    case "$choice" in 
      [yY])
        echo -e "${GREEN}正在配置安卓开发工具链...${NC}"
        sudo apt update
        sudo apt install -y openjdk-17-jdk
        mkdir -p ~/android-sdk/cmdline-tools/latest
        cd ~/android-sdk/cmdline-tools
        wget $CMDLINE_TOOLS
        unzip commandlinetools-linux-*.zip
        rm commandlinetools-linux-*.zip
        export ANDROID_HOME="${HOME}/android-sdk"
        export PATH="${ANDROID_HOME}/cmdline-tools/latest/bin:\${PATH}"
        export PATH="${ANDROID_HOME}/platform-tools:\${PATH}"
        yes | sdkmanager --licenses
        sdkmanager "cmdline-tools;latest"
        cd ~/android-sdk/cmdline-tools
        rm -rf latest
        mv latest-2 latest
        sdkmanager "build-tools;35.0.1"
        sdkmanager "platform-tools"
        sdkmanager "platforms;android-35"

        # 检查并写入 ANDROID_HOME
        if ! grep -qF "export ANDROID_HOME=\"${HOME}/android-sdk\"" "$TERMINAL_RC"; then
            echo -e "export ANDROID_HOME=\"${HOME}/android-sdk\"" >> "$TERMINAL_RC"
        fi
        # 检查并写入命令行工具路径
        if ! grep -qF "export PATH=\"${ANDROID_HOME}/cmdline-tools/latest/bin:\${PATH}\"" "$TERMINAL_RC"; then
            echo -e "export PATH=\"${ANDROID_HOME}/cmdline-tools/latest/bin:\${PATH}\"" >> "$TERMINAL_RC"
        fi
        # 检查并写入平台工具路径
        if ! grep -qF "export PATH=\"${ANDROID_HOME}/platform-tools:\${PATH}\"" "$TERMINAL_RC"; then
            echo -e "export PATH=\"${ANDROID_HOME}/platform-tools:\${PATH}\"" >> "$TERMINAL_RC"
        fi

        ;;
      *)
        echo -e "${RED}已跳过安卓工具链配置,可通过AndroiStudio自行配置"
        ;;
    esac
}

main() {
    check_dependency
    install_flutter
    install_desktop_toolchain
    install_android_toolchain
    echo -e "${GREEN}安装完成，使用 flutter doctor 验证安装完整性...${NC}"
    echo -e "${GREEN}请执行:source $TERMINAL_RC 使更改生效"
}
# 执行主线程
main
