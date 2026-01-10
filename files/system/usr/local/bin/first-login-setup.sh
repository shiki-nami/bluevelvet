#!/usr/bin/env bash

set -e

echo "开始首次登录设置..."

# 安装 cosign
echo "安装 cosign..."
brew install cosign

# 安装 Zed
echo "安装 Zed..."
curl -f https://zed.dev/install.sh | sh

# 安装 Claude
echo "安装 Claude..."
curl -fsSL https://claude.ai/install.sh | bash

# 设置 AppImages
echo ""
echo "设置 AppImage 应用"
echo "--------------------------------------"
/usr/local/bin/setup-appimages.sh

echo "首次登录设置完成!"
