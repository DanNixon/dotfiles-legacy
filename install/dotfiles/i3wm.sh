#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

patch_operation="df_$1"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/i3/config" \
  "$HOME/.config/i3/config"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/polybar/config" \
  "$HOME/.config/polybar/config"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/Xresources" \
  "$HOME/.Xresources"

set -x

# Copy Polybar scripts
cp \
  "$DOTFILES/dotfiles/dot_config/polybar/"*.sh \
  "$HOME/.config/polybar/"

# Reload xrdb
xrdb "$HOME/.Xresources"

# Restart i3wm
i3-msg restart
