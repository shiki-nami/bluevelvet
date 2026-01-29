#!/bin/bash

# 校验标记文件CRC32
BREWFILE="/usr/share/ublue-os/homebrew/bluevelvet.Brewfile"
MARKER_DIR="${HOME}/.config/brew-installed"
HASH=$(cksum "$BREWFILE" | awk '{print $1}')
MARKER_FILE="${MARKER_DIR}/${HASH}"

# 如果标记文件存在,直接退出
[[ -f "$MARKER_FILE" ]] && exit 0

# 创建标记目录
mkdir -p "$MARKER_DIR"

# 安装包,捕获输出
OUTPUT=$(/home/linuxbrew/.linuxbrew/bin/brew bundle --file="$BREWFILE" --no-lock 2>&1)
EXIT_CODE=$?

# 失败时输出错误并通知用户
if [ $EXIT_CODE -ne 0 ]; then
    echo "无法安装 Brewfile (checksum: $HASH)" >&2
    echo "$OUTPUT" >&2

    # 发送桌面通知
    notify-send -u critical \
        "Brew 安装失败" \
        "无法安装 Brew 软件包. 查看日志: journalctl --user -u setup-brew.service"

    exit $EXIT_CODE
fi

# 清理旧标记,创建新标记
rm -f "${MARKER_DIR}"/*
touch "$MARKER_FILE"
