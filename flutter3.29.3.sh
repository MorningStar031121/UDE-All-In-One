#!bin/bash
set -euo pipefail
# 全局配置
readonly FLUTTER_VERSION="3.29.3"
readonly FLUTTER_DIR="{$HOME}/Flutter/FlutterSDK"
readonly TERMINAL_RC="{$HOME}/.bashrc"

# 颜色定义
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

# Flutter安装配置
install_flutter() {
    if ! command -v wget &>/dev/null; then
        echo -e "${RED}错误：wget 未安装，请执行以下命令安装：${NC}"
        echo "sudo apt install wget"
        exit 1
    fi
	# 临时配置环境变量以便下载
	export PUB_HOSTED_URL="https://pub.flutter-io.cn"
    export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
    echo -e "${GREEN}正在下载Flutter SDK $FLUTTER_VERSION...${NC}"
    local flutter_url="https://storage.flutter-io.cn/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
    mkdir -p "$FLUTTER_DIR"
    wget "$flutter_url" -O /tmp/flutter.tar.xz
    
    echo -e "${GREEN}正在解压Flutter SDK...${NC}"
    tar -xf /tmp/flutter.tar.xz -C "$FLUTTER_DIR" --strip-components=1
    rm -f /tmp/flutter.tar.xz
    echo -e "${GREEN}配置环境变量到 $TERMINAL_RC...${NC}"
    cat <<EOT >> "$TERMINAL_RC"
    export PUB_HOSTED_URL="https://pub.flutter-io.cn"
    export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
    export PATH="$FLUTTER_DIR/bin:\$PATH"
    EOT
    echo -e "${GREEN}清理安装包...${NC}"
    rm /tmp/flutter
    source "$TERMINAL_RC"
}

main() {
	install_flutter
}
