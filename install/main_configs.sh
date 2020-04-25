#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

$(df_target "copy" "$1") \
  "$DOTFILES/third_party/base16-shell" \
  "$HOME/.config/base16-shell"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/nvim/init.vim" \
  "$HOME/.config/nvim/init.vim"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/mpd/mpd.conf" \
  "$HOME/.config/mpd/mpd.conf"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/mpv/config" \
  "$HOME/.config/mpv/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/mpv/input.conf" \
  "$HOME/.config/mpv/input.conf"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/ncmpcpp/bindings" \
  "$HOME/.config/ncmpcpp/bindings"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/ncmpcpp/config" \
  "$HOME/.config/ncmpcpp/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/shell_common/aliases.sh" \
  "$HOME/.config/shell_common/aliases.sh"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/shell_common/environment.sh" \
  "$HOME/.config/shell_common/environment.sh"

$(df_target "add_secrets" "$1") \
  "$HOME/.config/shell_common/environment.sh"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/dot_config/shell_common/global_aliases.sh" \
  "$HOME/.config/shell_common/global_aliases.sh"

$(df_target "copy" "$1") \
  "$DOTFILES/dotfiles/home/vim" \
  "$HOME/.vim"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/vimrc" \
  "$HOME/.vimrc"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/gdbinit" \
  "$HOME/.gdbinit"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/gitconfig" \
  "$HOME/.gitconfig"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/gitignore" \
  "$HOME/.gitignore"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/newsboat/config" \
  "$HOME/.newsboat/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/tmux.conf" \
  "$HOME/.tmux.conf"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/bashrc" \
  "$HOME/.bashrc"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/gnupg/dirmngr.conf" \
  "$HOME/.gnupg/dirmngr.conf"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/gnupg/gpg.conf" \
  "$HOME/.gnupg/gpg.conf"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/gnupg/gpg-agent.conf" \
  "$HOME/.gnupg/gpg-agent.conf"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/todo/config" \
  "$HOME/.todo/config"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/zshrc" \
  "$HOME/.zshrc"

df_exit_if_not_install "$1"

set +x

dircolors -b "$DOTFILES/dotfiles/dircolors.conf" > "$HOME/.ls_colors.sh"
