#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

operation="df_$1"

"$operation"\
  "$DOTFILES/dotfiles/dot_config/alacritty/alacritty.yml" \
  "$HOME/.config/alacritty/alacritty.yml"
