#!/bin/bash

xrandr \
  --output eDP-1 --primary --mode 3840x2160 \
  --output HDMI-1 --off

$HOME/dotfiles/install/desktop_environment_config.sh install
