#!/bin/bash

COLOUR_BAD="cc9090"

if [ "$(pgrep syncthing)" ]; then
  echo "痢"
else
  echo "裏 %{F#${COLOUR_BAD}}%{u#${COLOUR_BAD}}Syncthing not running%{u-}%{F-}"
fi
