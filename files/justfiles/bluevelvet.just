# 安装并配置 mihomo (Clash Meta)
setup-mihomo:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "正在安装 mihomo..."
    brew install mihomo

    echo "创建配置文件目录..."
    mkdir -p "$HOME/.config/mihomo"

    echo "配置 systemd 服务..."
    mkdir -p "$HOME/.config/systemd/user"

    MIHOMO_BIN="$(brew --prefix)/bin/mihomo"

    cat > "$HOME/.config/systemd/user/mihomo.service" << EOF
    [Unit]
    Description=mihomo Service
    After=network.target

    [Service]
    Type=simple
    ExecStart=$MIHOMO_BIN -d %h/.config/mihomo
    Restart=on-failure

    [Install]
    WantedBy=default.target
    EOF

    systemctl --user daemon-reload
    systemctl --user enable --now mihomo.service
    echo "mihomo 已安装并作为 systemd 服务启动。"
