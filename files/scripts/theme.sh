#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1 &&
cd WhiteSur-gtk-theme &&
./install.sh
