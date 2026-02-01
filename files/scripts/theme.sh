#!/usr/bin/env bash
set -euo pipefail

# 克隆 WhiteSur 主题仓库
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git /tmp/WhiteSur-gtk-theme

# 进入目录并安装
cd /tmp/WhiteSur-gtk-theme
./install.sh -t all -N glassy

# 清理
cd /
rm -rf /tmp/WhiteSur-gtk-theme