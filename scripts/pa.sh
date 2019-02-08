#!/bin/bash

default_sink=`pacmd dump | grep default-sink | awk '{print $2}'`

case "$1" in
  "v")
    pactl set-sink-volume "$default_sink" "$2"
    ;;
  "m")
    pactl set-sink-mute "$default_sink" "$2"
    ;;
  *)
    echo "nope"
    ;;
esac
