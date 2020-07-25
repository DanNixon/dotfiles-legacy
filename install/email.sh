#!/bin/bash

here="$( cd "$(dirname "$0")" ; pwd -P )"
. "$here/common.sh"

set -x

rm -rf "$HOME/.config/neomutt"

set +x

$(df_target "copy" "$1") \
  "$DOTFILES/dotfiles/dot_config/msmtp/config" \
  "$HOME/.config/msmtp/config"

$(df_target "copy" "$1") \
  "$DOTFILES/dotfiles/dot_config/neomutt" \
  "$HOME/.config/neomutt"

$(df_target "copy_patched" "$1") \
  "$DOTFILES/dotfiles/home/mbsyncrc" \
  "$HOME/.mbsyncrc"

df_exit_if_not_install "$1"

set -x

pass-add-secrets-to-file "$HOME/.config/msmtp/config"
pass-add-secrets-to-file "$HOME/.config/neomutt/accounts/gmail.neomuttrc"
pass-add-secrets-to-file "$HOME/.config/neomutt/accounts/outlook-1.neomuttrc"
pass-add-secrets-to-file "$HOME/.config/neomutt/accounts/outlook-2.neomuttrc"
pass-add-secrets-to-file "$HOME/.config/neomutt/accounts/protonmail.neomuttrc"
pass-add-secrets-to-file "$HOME/.mbsyncrc"
