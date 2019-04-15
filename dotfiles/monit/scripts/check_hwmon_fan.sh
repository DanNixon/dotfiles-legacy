#!/bin/bash

# Sample Monit config:
# check program NAME with path "/etc/monit/scripts/check_hwmon_fan.sh HWMON_PATH [THRESHOLD]"
#   if status != 0 then alert

DEVICE_PATH="$1"
threshold="${2:-50}"

if [ -e "${DEVICE_PATH}_label" ]; then
  device_name=`cat "${DEVICE_PATH}_label"`
else
  device_name="unknown"
fi

reading=`cat "${DEVICE_PATH}_input"`

check="$reading < $threshold"
if [[ `echo "$check" | bc` -eq 1 ]]; then
  echo "Speed of fan \"$device_name\" is below threshold ($check)"
  exit 1
else
  echo "Speed of fan \"$device_name\" is above threshold ($reading)"
  exit 0
fi
