#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

patch_operation="df_$1"

"$patch_operation"\
  "$DOTFILES/dotfiles/dot_config/alacritty/alacritty.yml" \
  "$HOME/.config/alacritty/alacritty.yml"

df_copy \
  "$DOTFILES/third_party/base16-shell" \
  "$HOME/.config/base16-shell"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/compton.conf" \
  "$HOME/.config/compton.conf"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/dunst/dunstrc" \
  "$HOME/.config/dunst/dunstrc"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/nvim/init.vim" \
  "$HOME/.config/nvim/init.vim"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/mpd/mpd.conf" \
  "$HOME/.config/mpd/mpd.conf"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/mpv/config" \
  "$HOME/.config/mpv/config"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/mpv/input.conf" \
  "$HOME/.config/mpv/input.conf"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/ncmpcpp/bindings" \
  "$HOME/.config/ncmpcpp/bindings"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/ncmpcpp/config" \
  "$HOME/.config/ncmpcpp/config"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/rofi/config" \
  "$HOME/.config/rofi/config"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/shell_common/aliases.sh" \
  "$HOME/.config/shell_common/aliases.sh"

"$patch_operation" \
  "$DOTFILES/dotfiles/dot_config/shell_common/environment.sh" \
  "$HOME/.config/shell_common/environment.sh"

df_copy \
  "$DOTFILES/dotfiles/home/vim" \
  "$HOME/.vim"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/vimrc" \
  "$HOME/.vimrc"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/gdbinit" \
  "$HOME/.gdbinit"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/gitconfig" \
  "$HOME/.gitconfig"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/gitignore" \
  "$HOME/.gitignore"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/tmux.conf" \
  "$HOME/.tmux.conf"

df_link \
  '/dev/null' \
  "$HOME/.bash_history"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/bashrc" \
  "$HOME/.bashrc"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/gnupg/dirmngr.conf" \
  "$HOME/.gnupg/dirmngr.conf"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/gnupg/gpg.conf" \
  "$HOME/.gnupg/gpg.conf"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/gnupg/gpg-agent.conf" \
  "$HOME/.gnupg/gpg-agent.conf"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/todo/config" \
  "$HOME/.todo/config"

df_link \
  "$DOTFILES/dotfiles/home/slic3r/" \
  "$HOME/.Slic3r"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/xprofile" \
  "$HOME/.profile"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/xprofile" \
  "$HOME/.xsessionrc"

"$patch_operation" \
  "$DOTFILES/dotfiles/home/zshrc" \
  "$HOME/.zshrc"

set +x

dircolors -b "$DOTFILES/dotfiles/dircolors.conf" > "$HOME/.ls_colors.sh"
