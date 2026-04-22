# 安装 Brewfile 中定义的包
install-brew:
    #!/bin/bash
    set -e
    
    BREWFILE_PATH="usr/share/ublue-os/homebrew/bluevelvet.Brewfile"
    
    if [ ! -f "$BREWFILE_PATH" ]; then
        echo "错误: Brewfile 文件不存在: $BREWFILE_PATH"
        exit 1
    fi
    
    echo "从 $BREWFILE_PATH 安装 Homebrew 包..."
    brew bundle install --file="$BREWFILE_PATH"
    echo "安装完成！"
