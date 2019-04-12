#!/bin/sh

if docker ps | grep --quiet "$1"; then
  echo "Container running"
  exit 0
else
  echo "Container not running or not known"
  exit 1
fi
