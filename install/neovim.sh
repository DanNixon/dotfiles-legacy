#!/bin/sh

curl \
  --output nvim \
  --location \
  'https://github.com/neovim/neovim/releases/download/v0.3.8/nvim.appimage'

chmod +x nvim

sudo mkdir -p '/usr/local/bin' && sudo mv nvim '/usr/local/bin'
