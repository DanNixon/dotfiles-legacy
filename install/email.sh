#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

$(df_target "copy" "$1") \
  "$DOTFILES/dotfiles/dot_config/msmtp/config" \
  "$HOME/.config/msmtp/config"

$(df_target "add_secrets" "$1") \
  "$HOME/.config/msmtp/config"

$(df_target "copy" "$1") \
  "$DOTFILES/dotfiles/dot_config/neomutt" \
  "$HOME/.config/neomutt"

$(df_target "add_secrets" "$1") \
  "$HOME/.config/neomutt/accounts/gmail.neomuttrc"

$(df_target "add_secrets" "$1") \
  "$HOME/.config/neomutt/accounts/outlook-1.neomuttrc"

$(df_target "add_secrets" "$1") \
  "$HOME/.config/neomutt/accounts/outlook-2.neomuttrc"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/mbsyncrc" \
  "$HOME/.mbsyncrc"

$(df_target "add_secrets" "$1") \
  "$HOME/.mbsyncrc"
