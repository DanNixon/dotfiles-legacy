#!/bin/bash

# Sample Monit config:
# check program NAME with path "/etc/monit/scripts/check_hwmon_fan.sh CHIP NAME [THRESHOLD]"
#   if status != 0 then alert

chip="$1"
sensor="$2"
threshold="${3:-50}"

value=`sensors -u "$chip" | grep "${sensor}_input" | cut -d ":" -f 2 | awk '{printf("%0.0f", $1)}'`

check="$value < $threshold"
if [[ `echo "$check" | bc` -eq 1 ]]; then
  echo "Speed of fan \"$sensor\" is below threshold (compare $check)"
  exit 1
else
  echo "Speed of fan \"$sensor\" is above threshold (compare $check)"
  exit 0
fi
