#!/bin/bash

default_sink=`pacmd dump | grep default-sink | awk '{print $2}'`


function active_port {
  ports=( speaker headphones )
  for i in "${ports[@]}"
  do
    if pacmd list-sinks | grep active | head -n 1 | grep -q $i;
    then
      echo $i
    fi
  done
}


function port_name_to_icon {
  case "$1" in
    "speaker")
      echo -n "蓼"
      ;;
    "headphones")
      echo -n ""
      ;;
    "hdmi")
      echo -n "﴿"
      ;;
  esac
}


case "$1" in
  "v")
    pactl set-sink-volume "$default_sink" "$2"
    ;;
  "m")
    pactl set-sink-mute "$default_sink" "$2"
    ;;
  "active-port")
    active_port
    ;;
  "active-port-icon")
    port_name_to_icon `active_port`
    ;;
  *)
    echo "nope"
    ;;
esac
