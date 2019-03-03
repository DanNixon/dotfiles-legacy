#!/bin/bash

chip="$1"
type="$2"
index="$3"

input_name="${type}${index}_input"
value=`sensors -u "$chip" | grep "$input_name" | cut -d ":" -f 2 | awk '{printf("%0.0f", $1)}'`

case "$type" in
  "temp")
    icon=""
    unit="糖"
    ;;
  "fan")
    icon=""
    unit="rpm"
    ;;
esac

printf "${icon} ${value}${unit}\n"
