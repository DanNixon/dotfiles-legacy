#!/bin/bash

if [ $# -eq 1 ]; then
  action="$1"
else
  action=$(echo -e 'lock\nsleep\nshutdown' | rofi -dmenu -i -p 'power/lock')
fi

case "$action" in
  "lock")
    i3lock --color 000000
    ;;
  "sleep")
    sync && i3lock --color 000000 && systemctl suspend
    ;;
  "shutdown")
    rofi_confirm 'shutdown now?' && sync && poweroff
    ;;
  *)
    exit 1
    ;;
esac
