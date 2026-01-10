#!/usr/bin/env bash

set -oue pipefail

dnf install -y $(curl -s https://api.github.com/repos/mihomo-party-org/clash-party/releases/latest | grep -o 'https://[^"]*clash-party-linux-[^"]*-x86_64\.rpm' | head -n1)
