#!/bin/bash

COLOUR_BAD="cc9090"

if [ "$(pgrep -x syncthing)" ]; then
  echo "痢"
else
  echo "%{F#${COLOUR_BAD}}%{u#${COLOUR_BAD}}裏 Syncthing not running%{u-}%{F-}"
fi
