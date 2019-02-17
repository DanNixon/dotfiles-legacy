#!/bin/bash

# Finds the active media player
# Checks for mpv, falls back to mpd/mpc
function which_player {
  if [ -z `pgrep mpv` ];
  then
    echo "mpd"
  else
    echo "mpv"
  fi
}


function mpv_command {
  echo "$1" | socat - /tmp/mpv-socket
}

function mpv_pause {
  mpv_command "cycle pause"
}

function mpv_prev {
  mpv_command "playlist-prev"
}

function mpv_next {
  mpv_command "playlist-next"
}

function mpv_stop {
  mpv_command "stop"
}


function mpd_pause {
  mpc toggle
}

function mpd_prev {
  mpc prev
}

function mpd_next {
  mpc next
}

function mpd_stop {
  mpc stop
}


echo "Player: `which_player`"

case "$1" in
  "pause" | "play")
    `which_player`_pause
    ;;
  "prev")
    `which_player`_prev
    ;;
  "next")
    `which_player`_next
    ;;
  "stop")
    `which_player`_stop
    ;;
  *)
    echo "nope"
    ;;
esac
