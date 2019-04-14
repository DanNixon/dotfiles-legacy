#!/bin/bash

# Sample Monit config:
# check program NAME with path "/etc/monit/scripts/check_hwmon_temperature.sh HWMON_PATH THRESHOLD"
#   if status != 0 then alert

DEVICE_PATH="$1"
THRESHOLD="$2"

if [ -e "${DEVICE_PATH}_label" ]; then
  device_name=`cat "${DEVICE_PATH}_label"`
else
  device_name="unknown"
fi

device_input=`cat "${DEVICE_PATH}_input"`
reading=`echo "$device_input / 1000" | bc`

check="$reading > $THRESHOLD"
if [[ `echo "$check" | bc` -eq 1 ]]; then
  echo "Temperature \"$device_name\" exceeds threshold ($check)"
  exit 1
else
  echo "Temperature \"$device_name\" below threshold ($reading)"
  exit 0
fi
