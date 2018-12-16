#!/bin/bash

youtube-dl \
  -ciw -v \
  -f "bestvideo[height<=720]+bestaudio/best[height<=720]" \
  -o "%(uploader)s/%(title)s (%(id)s).%(ext)s" \
  $@
