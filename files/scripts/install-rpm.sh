#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
# echo 'This is an example shell script'
# echo 'Scripts here will run during build if specified in recipe.yml'

dnf install -y \
    https://github.com/mihomo-party-org/clash-party/releases/download/v1.9.1/clash-party-linux-1.9.1-x86_64.rpm \
    https://github.com/Foundry376/Mailspring/releases/download/1.17.1/mailspring-1.17.1-0.1.x86_64.rpm \
    https://github.com/bitwarden/clients/releases/download/desktop-v2025.12.1/Bitwarden-2025.12.1-x86_64.rpm \
    https://github.com/imsyy/SPlayer/releases/download/v3.0.0-beta.8.2025/splayer-3.0.0-beta.8-x86_64.rpm \
&& \
dnf clean all
