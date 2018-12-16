#!/bin/bash

youtube-dl \
  -ciw -v \
  --write-sub \
  --all-subs \
  -o "%(series)s/S%(season_number)02d %(season)s/E%(episode_number)02d %(episode)s.%(ext)s" \
  $@
