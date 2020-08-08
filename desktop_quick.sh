#!/bin/sh

set +ex

profile="${1:-default}"

notify-send \
  'Desktop Reload' \
  "Desktop environment is being reloaded with profile \"$profile\", please wait warmly..."

cd "$(dirname "$0")" && ansible-playbook \
  desktop.yml \
  --skip-tags font_installation,package_installation \
  -e reload_sway=yes \
  -e target="$profile"
