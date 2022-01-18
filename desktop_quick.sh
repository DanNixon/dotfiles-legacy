#!/bin/sh

set -ex

profile="${1:-default}"

notify-send \
  'Desktop Reload' \
  "Desktop environment is being reloaded with profile \"$profile\", please wait warmly..."

cd "$(dirname "$0")" && ansible-playbook \
  "$(uname -n).yml" \
  --tags desktop_environment_quick \
  -e desktop_environment_profile="$profile"
