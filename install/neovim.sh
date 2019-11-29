#!/bin/sh

set -ex

curl \
  --output nvim \
  --location \
  'https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage'

chmod +x nvim

sudo mkdir -p '/usr/local/bin'
sudo mv nvim '/usr/local/bin'
