#!/bin/bash

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
. "$HERE/conf.sh"

df_link \
  "$DOTFILES/dotfiles/polybar" \
  "$HOME/.config/polybar"

set -x

# base16 theme
theme="base16-material"

# Make config directory
i3_config_dir="$HOME/.config/i3"
mkdir -p "$i3_config_dir"

# Separate config filenames
theme_config_file="$DOTFILES/dotfiles/i3/base16-i3/colors/${theme}.config"
common_confg_file="$DOTFILES/dotfiles/i3/config"

# Generate config file
cat "$theme_config_file" "$common_confg_file" > "$i3_config_dir/config"

# Restart i3wm
i3-msg restart