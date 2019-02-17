#!/bin/bash

youtube-dl \
  -ciw -v \
  --write-sub \
  --all-subs \
  $@
