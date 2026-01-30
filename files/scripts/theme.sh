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
./install.sh

echo "WhiteSur GTK theme installation completed successfully!"
