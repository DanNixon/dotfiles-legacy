#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/alacritty/alacritty.yml" \
  "$HOME/.config/alacritty/alacritty.yml"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/compton.conf" \
  "$HOME/.config/compton.conf"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/dunst/dunstrc" \
  "$HOME/.config/dunst/dunstrc"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/i3/config" \
  "$HOME/.config/i3/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/polybar/config" \
  "$HOME/.config/polybar/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/rofi/config" \
  "$HOME/.config/rofi/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/xprofile" \
  "$HOME/.profile"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/Xresources" \
  "$HOME/.Xresources"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/xprofile" \
  "$HOME/.xsessionrc"

df_exit_if_not_install "$1"

set -x

# Copy Polybar scripts
cp \
  "$DOTFILES/dotfiles/dot_config/polybar/"*.sh \
  "$HOME/.config/polybar/"

# Reload xrdb
xrdb "$HOME/.Xresources"

# Restart i3wm
i3-msg restart
