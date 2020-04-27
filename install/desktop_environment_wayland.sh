#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/alacritty/alacritty.yml" \
  "$HOME/.config/alacritty/alacritty.yml"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/sway/config" \
  "$HOME/.config/sway/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/waybar/config.json" \
  "$HOME/.config/waybar/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/waybar/style.css" \
  "$HOME/.config/waybar/style.css"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/wofi/style.css" \
  "$HOME/.config/wofi/style.css"

df_exit_if_not_install "$1"

set -x

swaymsg reload
