#!/bin/sh

xrandr --output HDMI-1-2 --off --output eDP-1-1 --mode 3840x2160 --pos 0x0 --rotate normal --output HDMI-1-1 --off --output DP-1-1 --off --output DP-1-2 --off

cp Xresources_laptop ~/.Xresources
xrdb ~/.Xresources

polybar-launch
i3-msg restart
