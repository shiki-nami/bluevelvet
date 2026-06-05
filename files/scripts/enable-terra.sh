#!/usr/bin/env bash
set -euo pipefail

# 替换首个 enabled=0
if [ -f /etc/yum.repos.d/terra.repo ]; then
  sed -i '0,/enabled=0/{s/enabled=0/enabled=1/}' /etc/yum.repos.d/terra.repo
  echo "成功启用 [terra] 软件仓库"
else
  echo "警告: 未找到 terra.repo 文件"
fi
