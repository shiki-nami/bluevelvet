#!/usr/bin/env bash

set -e

echo "开始下载和集成 AppImage 应用..."

# 下载并集成 AppImage
download_and_integrate() {
    local repo=$1
    local filename_pattern=$2
    local output_name=$3

    echo "正在获取 $output_name 的下载链接..."

    # 将 * 替换为 .* 用于 grep
    local grep_pattern="${filename_pattern//\*/.*}"

    # 获取最新版本的下载 URL
    DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | \
                   grep -oE "https://[^\"]*$grep_pattern" | head -n1)

    if [ -z "$DOWNLOAD_URL" ]; then
        echo "⚠ 错误: 无法找到 $output_name 的下载链接"
        return 1
    fi

    echo "下载 $output_name..."

    # 下载到 ~/Downloads
    wget -q --show-progress -O "$HOME/Downloads/$output_name" "$DOWNLOAD_URL"
    chmod +x "$HOME/Downloads/$output_name"

    echo "✓ $output_name 下载完成"

    # 集成到系统
    echo "使用 Gear Lever 集成 $output_name..."
    UPDATE_URL="https://github.com/$repo/releases/download/*/$filename_pattern"

    flatpak run it.mijorus.gearlever --integrate "$HOME/Downloads/$output_name"
    flatpak run it.mijorus.gearlever --set-update-url "$output_name" "$UPDATE_URL"

    echo "✓ $output_name 已集成"
    echo ""
}

# AppImage 应用列表
APPIMAGES=(
    "imsyy/SPlayer|splayer-*-x86_64.AppImage|SPlayer.AppImage"
)

# 批量处理
for app in "${APPIMAGES[@]}"; do
    IFS='|' read -r repo pattern name <<< "$app"
    download_and_integrate "$repo" "$pattern" "$name"
done

echo "======================================"
echo "完成!"
echo "======================================"
