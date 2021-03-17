#!/bin/bash

set -eo pipefail

pwname="$(find "$HOME/.password-store/" -name "*.gpg" -printf "%P\n" | sed -e "s/\.gpg//g" | fzf)"
if [ ! $? -eq 0 ]; then
  exit $?
fi

mode=$(cat <<EOF | fzf
text type
otp type
otp copy
otp
text qr
text copy once
text copy
text
EOF
);

case "$mode" in
  'text')
    pass "$pwname"
    ;;
  'text copy')
    pass "$pwname" | wl-copy
    ;;
  'text copy once')
    pass "$pwname" | wl-copy --paste-once
    ;;
  'text type')
    pass "$pwname" | tr -d '\n' | wtype -
    ;;
  'text qr')
    pass "$pwname" | qrencode -t UTF8
    ;;
  'otp')
    pass otp "$pwname"
    ;;
  'otp copy')
    pass otp "$pwname" | wl-copy
    ;;
  'otp type')
    pass otp "$pwname" | tr -d '\n' | wtype -
    ;;
  *)
    exit 1
esac
