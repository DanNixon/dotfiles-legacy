#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

operation="df_$1"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/i3/config" \
  "$HOME/.config/i3/config"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/polybar/config" \
  "$HOME/.config/polybar/config"

set -x

# Copy Polybar scripts
cp \
  "$DOTFILES/dotfiles/dot_config/polybar/"*.sh \
  "$HOME/.config/polybar/"

# Restart i3wm
i3-msg restart
