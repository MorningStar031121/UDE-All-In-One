# 使用说明

## 脚本使用说明

1. 下载脚本文件压缩包
    
    ```bash
    curl -O https://raw.githubusercontent.com/MorningStar031121/UDE-All-In-One/refs/heads/Go/goWithGvm.zip
    # 或
    wget https://raw.githubusercontent.com/MorningStar031121/UDE-All-In-One/refs/heads/Go/goWithGvm.zip
    ```
    
2. 解压文件
    
    ```bash
    unzip goWithGvm.zip
    # 若无zip可以安装
    sudo apt update
    sudo apt install zip
    ```
    
3. 执行脚本
    
    ```bash
    ./goWithGvm
    ```
    
4. 重启终端或执行以下命令使安装生效
    
    ```bash
    source ~/.gvm/scripts/gvm
    ```
    

## 使用GVM管理Go(仅限Linux)
    
1. 验证安装
    
    ```bash
    gvm version
    ```
    
2. 获取帮助
    
    ```bash
    gvm help
    ```
    
3. 安装不同版本的Go
    
    ```bash
    export GOPROXY=https://goproxy.cn,direct // 可选，国内加快下载速度
    gvm install go1.24.2
    ```
    
4. 第一次安装Go可能会遇到编译问题失败，因为新版本的Go依赖于旧版本的Go作为引导
    
    ```bash
    # 第一次安装可以直接安装编译好的二进制
    gvm install go1.24.2 -B
    ```
    
5. 使用不同版本的go
    
    ```bash
    gvm use go1.24.2
    --default 作为默认版本
    ```
    
6. 卸载使用GVM安装的Go
    
    ```bash
    gvm uninstall go1.24.2
    ```
    
7. 卸载GVM
    
    ```bash
    gvm implode
    ```
