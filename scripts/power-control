#!/bin/bash

if [ $# -eq 1 ]; then
  action="$1"
else
  action=$(echo -e 'lock\nsleep\nshutdown\nreboot' | rofi -dmenu -i -p 'power/lock')
fi

case "$action" in
  "lock")
    i3lock --color 000000
    ;;
  "sleep")
    sync && i3lock --color 000000 && systemctl suspend
    ;;
  "shutdown")
    rofi-confirm 'shutdown now?' && sync && poweroff
    ;;
  "reboot")
    rofi-confirm 'reboot now?' && sync && reboot
    ;;
  *)
    exit 1
    ;;
esac
