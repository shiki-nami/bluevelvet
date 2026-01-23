#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
# echo 'This is an example shell script'
# echo 'Scripts here will run during build if specified in recipe.yml'

brew install \
     gh \
     cosign \
     wasmer \
     xlsclients \
     claude-code \

curl -f https://zed.dev/install.sh | sh
