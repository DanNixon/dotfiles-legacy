#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

operation="df_$1"

"$operation"\
  "$DOTFILES/dotfiles/dot_config/alacritty/alacritty.yml" \
  "$HOME/.config/alacritty/alacritty.yml"

df_link \
  "$DOTFILES/third_party/base16-shell" \
  "$HOME/.config/base16-shell"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/compton.conf" \
  "$HOME/.config/compton.conf"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/dunst/dunstrc" \
  "$HOME/.config/dunst/dunstrc"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/nvim/init.vim" \
  "$HOME/.config/nvim/init.vim"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/mpd/mpd.conf" \
  "$HOME/.config/mpd/mpd.conf"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/mpv/config" \
  "$HOME/.config/mpv/config"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/mpv/input.conf" \
  "$HOME/.config/mpv/input.conf"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/ncmpcpp/bindings" \
  "$HOME/.config/ncmpcpp/bindings"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/ncmpcpp/config" \
  "$HOME/.config/ncmpcpp/config"

"$operation" \
  "$DOTFILES/dotfiles/dot_config/rofi/config" \
  "$HOME/.config/rofi/config"

df_link \
  "$DOTFILES/dotfiles/home/vim" \
  "$HOME/.vim"

"$operation" \
  "$DOTFILES/dotfiles/home/vimrc" \
  "$HOME/.vimrc"

"$operation" \
  "$DOTFILES/dotfiles/home/gdbinit" \
  "$HOME/.gdbinit"

"$operation" \
  "$DOTFILES/dotfiles/home/gitconfig" \
  "$HOME/.gitconfig"

"$operation" \
  "$DOTFILES/dotfiles/home/gitignore" \
  "$HOME/.gitignore"

"$operation" \
  "$DOTFILES/dotfiles/home/tmux.conf" \
  "$HOME/.tmux.conf"

df_link \
  '/dev/null' \
  "$HOME/.bash_history"

"$operation" \
  "$DOTFILES/dotfiles/home/bashrc" \
  "$HOME/.bashrc"

"$operation" \
  "$DOTFILES/dotfiles/home/gnupg/dirmngr.conf" \
  "$HOME/.gnupg/dirmngr.conf"

"$operation" \
  "$DOTFILES/dotfiles/home/gnupg/gpg.conf" \
  "$HOME/.gnupg/gpg.conf"

"$operation" \
  "$DOTFILES/dotfiles/home/gnupg/gpg-agent.conf" \
  "$HOME/.gnupg/gpg-agent.conf"

"$operation" \
  "$DOTFILES/dotfiles/home/todo/config" \
  "$HOME/.todo/config"

df_link \
  "$DOTFILES/dotfiles/home/slic3r/" \
  "$HOME/.Slic3r"

"$operation" \
  "$DOTFILES/dotfiles/home/xprofile" \
  "$HOME/.profile"

"$operation" \
  "$DOTFILES/dotfiles/home/xprofile" \
  "$HOME/.xsessionrc"

"$operation" \
  "$DOTFILES/dotfiles/home/zshrc" \
  "$HOME/.zshrc"

set +x

dircolors -b "$DOTFILES/dotfiles/dircolors.conf" > ~/.ls_colors.sh
