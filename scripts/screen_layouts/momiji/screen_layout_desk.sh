#!/bin/bash

set -x

HERE="$( cd "$(dirname "$0")" ; pwd -P )"

xrandr --output HDMI-1-2 --off --output eDP-1-1 --off --output HDMI-1-1 --mode 3840x2160 --pos 0x0 --rotate normal --output DP-1-1 --off --output DP-1-2 --off

cp "$HERE/Xresources_desk" "$HOME/.Xresources"
xrdb "$HOME/.Xresources"

polybar-launch
i3-msg restart
