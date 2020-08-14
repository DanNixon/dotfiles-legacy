#!/bin/sh

set +ex

profile="${1:-default}"

notify-send \
  'Desktop Reload' \
  "Desktop environment is being reloaded with profile \"$profile\", please wait warmly..."

cd "$(dirname "$0")" && ansible-playbook \
  "$(hostname).yml" \
  --tags desktop_environment \
  --skip-tags font_installation,package_installation \
  -e sway_reload=yes \
  -e profile="$profile"
