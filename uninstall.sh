#!/bin/bash
set -euo pipefail

# 全局配置(需与安装脚本保持一致)
readonly FLUTTER_DIR="${HOME}/Flutter/FlutterSDK"
readonly ANDROID_SDK_DIR="${HOME}/android-sdk"
readonly TERMINAL_RC="${HOME}/.bashrc"

# 颜色定义
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

# 删除Flutter相关
uninstall_flutter() {
    echo -e "${GREEN}正在删除Flutter SDK...${NC}"
    [ -d "$FLUTTER_DIR" ] && rm -rf "$FLUTTER_DIR"

    echo -e "${GREEN}清理Flutter缓存...${NC}"
    rm -rf ~/.pub-cache ~/.flutter ~/snap/flutter
    
    # 从环境变量删除配置
    echo -e "${GREEN}清理环境变量...${NC}"
    sed -i '/export PUB_HOSTED_URL=.*/d' "$TERMINAL_RC"
    sed -i '/export FLUTTER_STORAGE_BASE_URL=.*/d' "$TERMINAL_RC"
    sed -i "s|export PATH=.*FlutterSDK/bin:\$PATH||" "$TERMINAL_RC"
    sed -i '/^$/N;/^\n$/D' "$TERMINAL_RC"  # 删除空行
}

# 删除Android工具链
uninstall_android() {
    echo -e "${GREEN}正在删除Android SDK...${NC}"
    [ -d "$ANDROID_SDK_DIR" ] && rm -rf "$ANDROID_SDK_DIR"
    
    echo -e "${GREEN}清理Android缓存...${NC}"
    rm -rf ~/.android ~/.gradle
    
    # 删除环境变量
    sed -i '/export ANDROID_HOME=.*/d' "$TERMINAL_RC"
    sed -i '/export PATH=.*android-sdk\/cmdline-tools/d' "$TERMINAL_RC"
    sed -i '/export PATH=.*android-sdk\/platform-tools/d' "$TERMINAL_RC"
}

# 可选清理开发工具链
clean_development_tools() {
    echo -ne "${RED}是否卸载开发工具链？(clang/cmake/JDK等，不建议)(y/N):${NC}"
    read -r choice
    case "$choice" in
      [yY])
        echo -e "${GREEN}正在移除开发工具...${NC}"
        sudo apt remove -y \
            clang cmake libgtk-3-dev ninja-build pkg-config \
            liblzma-dev libstdc++-12-dev openjdk-17-jdk
        ;;
      *)
        echo -e "${GREEN}保留开发工具链${NC}"
        ;;
    esac
}

# 最终验证
verify_uninstall() {
    echo -e "\n${GREEN}卸载完成，请执行以下操作：${NC}"
    echo "1. 手动检查残留文件:"
    echo "   - ~/AndroidStudioProjects"
    echo "   - ~/.config/Google"
    echo "2. 重启终端或执行: source $TERMINAL_RC"
}

main() {
    uninstall_flutter
    uninstall_android
    clean_development_tools
    verify_uninstall
}

main
