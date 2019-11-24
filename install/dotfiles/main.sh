#!/bin/bash

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
. "$HERE/conf.sh"

df_link \
  "$DOTFILES/dotfiles/alacritty" \
  "$HOME/.config/alacritty"

df_link \
  "$DOTFILES/third_party/base16-shell" \
  "$HOME/.config/base16-shell"

df_link \
  "$DOTFILES/dotfiles/compton.conf" \
  "$HOME/.config/compton.conf"

df_link \
  "$DOTFILES/dotfiles/dunst" \
  "$HOME/.config/dunst"

df_link \
  "$DOTFILES/dotfiles/direnvrc" \
  "$HOME/.config/direnv/direnvrc"

df_link \
  "$DOTFILES/dotfiles/nvim" \
  "$HOME/.config/nvim"

df_link \
  "$DOTFILES/dotfiles/mpd" \
  "$HOME/.config/mpd"

df_link \
  "$DOTFILES/dotfiles/mpv" \
  "$HOME/.config/mpv"

df_link \
  "$DOTFILES/dotfiles/ncmpcpp" \
  "$HOME/.config/ncmpcpp"

df_link \
  "$DOTFILES/dotfiles/rofi" \
  "$HOME/.config/rofi"

df_link \
  "$DOTFILES/dotfiles/vim" \
  "$HOME/.vim"

df_link \
  "$DOTFILES/dotfiles/vimrc" \
  "$HOME/.vimrc"

df_link \
  "$DOTFILES/dotfiles/gdb/gdbinit" \
  "$HOME/.gdbinit"

df_link \
  "$DOTFILES/dotfiles/gitconfig" \
  "$HOME/.gitconfig"

df_link \
  "$DOTFILES/dotfiles/gitignore" \
  "$HOME/.gitignore"

df_link \
  "$DOTFILES/dotfiles/screenrc" \
  "$HOME/.screenrc"

df_link \
  "$DOTFILES/dotfiles/tmux.conf" \
  "$HOME/.tmux.conf"

df_link \
  '/dev/null' \
  "$HOME/.bash_history"

df_link \
  "$DOTFILES/dotfiles/bashrc" \
  "$HOME/.bashrc"

df_link \
  "$DOTFILES/dotfiles/gnupg/dirmngr.conf" \
  "$HOME/.gnupg/dirmngr.conf"

df_link \
  "$DOTFILES/dotfiles/gnupg/gpg.conf" \
  "$HOME/.gnupg/gpg.conf"

df_link \
  "$DOTFILES/dotfiles/gnupg/gpg-agent.conf" \
  "$HOME/.gnupg/gpg-agent.conf"

df_link \
  "$DOTFILES/dotfiles/todo" \
  "$HOME/.todo"

df_link \
  "$DOTFILES/dotfiles/slic3r/" \
  "$HOME/.Slic3r"

df_link \
  "$DOTFILES/dotfiles/xprofile" \
  "$HOME/.profile"

df_link \
  "$DOTFILES/dotfiles/xprofile" \
  "$HOME/.xsessionrc"

df_link \
  "$DOTFILES/dotfiles/zshrc" \
  "$HOME/.zshrc"

set +x

dircolors -b "$DOTFILES/dotfiles/dircolors.conf" > ~/.ls_colors.sh
