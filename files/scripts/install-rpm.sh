#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
# echo 'This is an example shell script'
# echo 'Scripts here will run during build if specified in recipe.yml'
dnf install -y \
    https://github.com/mihomo-party-org/clash-party/releases/download/v1.9.1/clash-party-linux-1.9.1-x86_64.rpm
