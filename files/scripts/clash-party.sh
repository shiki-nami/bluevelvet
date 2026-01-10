#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
dnf install -y $(curl -s https://api.github.com/repos/mihomo-party-org/clash-party/releases/latest | grep -o 'https://[^"]*clash-party-linux-[^"]*-x86_64\.rpm' | head -n1) && \
dnf clean all && \
rm -rf /var/cache/dnf/* /var/cache/yum/* /tmp/* /var/tmp/* /var/lib/dnf/history
