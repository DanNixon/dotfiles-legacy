#!/bin/bash

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
. "$HERE/conf.sh"

df_link \
  "$DOTFILES/dotfiles/fish" \
  "$HOME/.config/fish/conf.d"
