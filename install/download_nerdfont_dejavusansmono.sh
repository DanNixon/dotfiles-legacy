#!/bin/bash

temp_dir="/tmp/nerdfont"

mkdir -p "$temp_dir"
cd "$temp_dir"

font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip"

archive="nerdfont.zip"

curl \
  --location \
  --output "$archive" \
  "$font_url"

unzip "$archive"
rm "$archive"
