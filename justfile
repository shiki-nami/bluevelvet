# 安装用户软件
install-user:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "开始安装用户软件..."

    # 通过Homebrew安装
    brew install \
         gh \
         cosign \
         wasmer \
         xlsclients \
         claude-code

    # 通过脚本安装
    curl -f https://zed.dev/install.sh | sh

    mkdir -p "$HOME/.config"
    touch "$HOME/.config/user-installed"

    echo "所有用户软件安装完成！"
