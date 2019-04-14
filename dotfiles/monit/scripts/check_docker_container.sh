#!/bin/sh

# Sample Monit config:
# check program NAME with path "/etc/monit/scripts/check_docker_container.sh CONTAINER_NAME"
#   if status != 0 then alert

if docker ps | grep --quiet "$1"; then
  echo "Container running"
  exit 0
else
  echo "Container not running or not known"
  exit 1
fi
