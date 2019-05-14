#!/bin/bash

# Sample Monit config:
# check program temp_1 with path "/etc/monit/scripts/check_hdd_temperature.sh /dev/sda 40"
  # if status != 0 then alert

device="$1"
threshold="$2"

reading=`smartctl --attributes $device | grep Temperature_Celsius | awk '{printf "%d", $10}'`

check="$reading > $threshold"
if [[ `echo "$check" | bc` -eq 1 ]]; then
  echo "Temperature of $device exceeds threshold ($check)"
  exit 1
else
  echo "Temperature of $device below threshold ($reading)"
  exit 0
fi
