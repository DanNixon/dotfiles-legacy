#!/bin/sh

mkdir -p "$HOME/.local/bin"
cd "$HOME/.local/bin"

curl \
  --output nvim \
  --location \
  'https://github.com/neovim/neovim/releases/download/v0.3.8/nvim.appimage'

chmod +x nvim
