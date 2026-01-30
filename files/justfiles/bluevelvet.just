setup-mihomo:
	#!/usr/bin/env bash
	set -euo pipefail

	echo "正在安装 mihomo..."
	brew install mihomo

	echo "创建配置文件目录..."
	mkdir -p "$HOME/.config/mihomo"

	echo "配置 systemd 服务..."
	MIHOMO_BIN="$(brew --prefix)/bin/mihomo"

	# 提前赋予变量，避免$HOME解析为/root
	CONFIG_DIR="$HOME/.config/mihomo"

	# 1. 正常缩进编写，保证 just 解析正确
	# 2. 写入临时文件，然后用 sed 删掉行首空格再移交给 sudo
	cat > /tmp/mihomo.service << EOF
	[Unit]
	Description=mihomo Service
	After=network-online.target
	Wants=network-online.target

	[Service]
	ExecStart=$MIHOMO_BIN -d $CONFIG_DIR
	User=root
	Restart=on-failure

	[Install]
	WantedBy=multi-user.target
	EOF

	# 使用 sed 删除每一行开头的空格或制表符，然后写入系统目录
	sed 's/^[[:space:]]*//' '/tmp/mihomo.service' | sudo tee '/etc/systemd/system/mihomo.service' > /dev/null
	rm '/tmp/mihomo.service'

	sudo systemctl daemon-reload
	sudo systemctl enable --now mihomo.service
	echo "mihomo 已安装并作为系统级服务启动。"
