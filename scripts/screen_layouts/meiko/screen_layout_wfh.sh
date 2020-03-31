#!/bin/sh

xrandr \
  --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 \
  --output HDMI-1 --mode 1920x1080 --pos 0x0

PATCH_TARGET="$(hostname)_1080p" $HOME/dotfiles/install/desktop_environment_config.sh install
