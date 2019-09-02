#!/bin/bash

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
. "$HERE/conf.sh"

df_link \
  "$DOTFILES/dotfiles/omf" \
  "$HOME/.config/omf"

shell_aliases \
  "fish_abbr" \
  "$HOME/.config/fish/abbreviations.fish"

set -x

curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > omf_install && \
  fish omf_install --noninteractive && \
  rm omf_install
