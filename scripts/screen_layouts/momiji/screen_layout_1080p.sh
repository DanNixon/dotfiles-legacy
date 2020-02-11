#!/bin/bash

xrandr --output eDP-1-1 --mode 1920x1080
PATCH_TARGET="$(hostname)_1080p" $HOME/dotfiles/install/desktop_environment_config.sh install
$HOME/.fehbg
