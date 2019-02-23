#!/bin/bash

. script_connon.sh

if [ "$(pgrep -x syncthing)" ]; then
  echo "痢"
else
  echo "%{F#${COLOUR_BAD}}%{u#${COLOUR_BAD}}裏 Syncthing not running%{u-}%{F-}"
fi
