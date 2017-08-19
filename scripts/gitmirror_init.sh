#!/bin/bash

NORMAL='\033[0m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'

while read line
do
  IFS=' ' read -r -a data <<< "${line}"
  remoteUrl="${data[0]}"
  clonePath="${data[1]}"

  targetDir="`dirname ${clonePath}`"
  mkdir -p "${targetDir}"

  printf "Cloning remote ${YELLOW}${remoteUrl}${NORMAL} into ${CYAN}${clonePath}${NORMAL}\n"
  git clone --mirror $remoteUrl $clonePath
done
