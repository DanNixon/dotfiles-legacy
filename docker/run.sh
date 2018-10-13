#!/bin/bash

docker run \
  --rm -it \
  -e PUID=`id --user` \
  -e PGID=`id --group` \
  -v ${HOME}:/home/dan \
  dannixon/dotfiles:latest
