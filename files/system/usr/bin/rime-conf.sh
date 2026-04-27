#!/bin/bash
TARGET_DIR="$HOME/.config/ibus/rime"

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# 已有 git 仓库则拉取
if [ -d ".git" ]; then
    git pull
else
    # 否则克隆
    git clone --depth 1 https://github.com/gaboolic/rime-frost .
fi

ibus restart