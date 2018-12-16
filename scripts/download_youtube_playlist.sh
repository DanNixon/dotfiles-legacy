#!/bin/bash

youtube-dl \
  -ciw -v \
  -f "bestvideo[height<=720]+bestaudio/best[height<=720]" \
  -o "%(playlist_title)s/%(title)s (%(id)s).%(ext)s" \
  $@
