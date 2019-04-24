#!/bin/bash

COLOUR_BAD="ffaaaa"

if [ "$(pgrep -x syncthing)" ]; then
  echo "痢"
else
  echo "%{F#${COLOUR_BAD}}%{u#${COLOUR_BAD}}裏 Syncthing!%{u-}%{F-}"
fi
