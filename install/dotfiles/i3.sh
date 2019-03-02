#!/bin/bash

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
. "$HERE/conf.sh"

df_link \
  "$DOTFILES/dotfiles/polybar" \
  "$HOME/.config/polybar"

set -x

./dotfiles/i3/generate_config
i3-msg restart
