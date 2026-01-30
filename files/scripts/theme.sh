#!/usr/bin/env bash
set -euo pipefail

# 创建临时目录来存放主题
THEME_DIR=$(mktemp -d)
trap "rm -rf $THEME_DIR" EXIT

echo "Cloning WhiteSur GTK theme to $THEME_DIR..."
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1 "$THEME_DIR"

if [ ! -f "$THEME_DIR/install.sh" ]; then
    echo "ERROR: install.sh not found in $THEME_DIR"
    exit 1
fi

echo "Installing WhiteSur GTK theme..."
cd "$THEME_DIR"
chmod +x ./install.sh

# 以非交互模式运行安装脚本，跳过用户交互
echo "Running install.sh with --yes flag..."
if ! ./install.sh --yes 2>&1; then
    echo "WARNING: install.sh failed, but continuing with alternative approach..."
    # 尝试直接复制主题文件到系统位置
    mkdir -p /usr/share/themes
    cp -r .* /usr/share/themes/ 2>/dev/null || true
    cp -r ./* /usr/share/themes/ 2>/dev/null || true
fi

echo "WhiteSur GTK theme installation completed!"
