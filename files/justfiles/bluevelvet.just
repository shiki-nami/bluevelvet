setup-mihomo:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "正在安装 mihomo..."
    brew install mihomo

    echo "检测调用用户与家目录..."
    OWNER="${SUDO_USER:-$USER}"
    OWNER_HOME="$(getent passwd "$OWNER" | cut -d: -f6 || echo "$HOME")"
    CONFIG_DIR="$OWNER_HOME/.config/mihomo"

    echo "创建配置文件目录并设置归属..."
    mkdir -p "$CONFIG_DIR"
    sudo chown -R "$OWNER":"$OWNER" "$CONFIG_DIR"

    echo "配置 systemd 服务..."
    MIHOMO_BIN="$(brew --prefix)/bin/mihomo"

    # 写入临时 unit 文件（先在本地写入，避免 sudo 下的变量展开问题），
    # 然后用 sed 去除缩进并交给 sudo 写入 /etc
    cat > /tmp/mihomo.service << EOF
    [Unit]
    Description=mihomo Service
    After=network-online.target
    Wants=network-online.target

    [Service]
    Environment=HOME=$OWNER_HOME
    WorkingDirectory=$OWNER_HOME
    ExecStart=$MIHOMO_BIN -d $CONFIG_DIR
    User=$OWNER
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    EOF

    sed 's/^[[:space:]]*//' '/tmp/mihomo.service' | sudo tee '/etc/systemd/system/mihomo.service' > /dev/null
    rm '/tmp/mihomo.service'

    sudo systemctl daemon-reload
    sudo systemctl enable --now mihomo.service
    echo "mihomo 已安装并作为 systemd 服务启动（以 $OWNER 身份运行）。"
