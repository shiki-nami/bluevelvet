#!/usr/bin/env python3
"""安装 Brewfile 并标记 CRC32"""

import subprocess
import sys
import zlib
from contextlib import suppress
from pathlib import Path


def extract_error(output: str) -> str:
    """提取关键错误信息"""
    lines = [line.strip() for line in output.strip().split('\n') if line.strip()]
    
    # 查找错误关键词
    for line in lines:
        if any(kw in line.lower() for kw in ['error', 'failed', 'fatal', 'cannot']):
            return line
    
    # 返回最后一行非空输出
    return lines[-1] if lines else '安装失败'


def main() -> int:
    # 路径配置
    brewfile = Path('/usr/share/ublue-os/homebrew/bluevelvet.Brewfile')
    marker_dir = Path.home() / '.config' / 'brew-installed'
    marker_file = marker_dir / f"{zlib.crc32(brewfile.read_bytes()) & 0xffffffff}"
    
    # 早期返回
    if marker_file.exists():
        return 0
    
    marker_dir.mkdir(parents=True, exist_ok=True)
    
    # 执行安装
    result = subprocess.run(
        ['/home/linuxbrew/.linuxbrew/bin/brew', 'bundle', 
         f'--file={brewfile}', '--no-lock'],
        capture_output=True,
        text=True
    )
    
    # 失败处理
    if result.returncode:
        output = f"{result.stdout}{result.stderr}"
        sys.stderr.write(output)
        
        # 发送错误摘要通知
        with suppress(Exception):
            subprocess.run(
                ['notify-send', '-u', 'critical', 'Brew 安装失败', 
                 extract_error(output)],
                timeout=5,
                capture_output=True
            )
        return result.returncode
    
    # 成功后才清理旧标记并创建新标记
    for old_marker in marker_dir.glob('[0-9]*'):
        old_marker.unlink(missing_ok=True)
    
    marker_file.touch()
    return 0


if __name__ == '__main__':
    sys.exit(main())
