#!/bin/bash

set -ex

font_dir="$HOME/.fonts"
font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip'

mkdir -p "$font_dir"
cd "$font_dir"

archive='nerdfont.zip'

curl \
  --location \
  --output "$archive" \
  "$font_url"

unzip "$archive"
rm "$archive"

# Rebuild font cache
fc-cache --force --verbose
