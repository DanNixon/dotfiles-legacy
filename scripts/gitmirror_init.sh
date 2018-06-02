#!/bin/bash

NORMAL='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'

while read line
do
  IFS=' ' read -r -a data <<< "${line}"
  remoteUrl="${data[0]}"
  clonePath="${data[1]}"

  printf "${BLUE}${remoteUrl}${NORMAL} => ${CYAN}${clonePath}${NORMAL}\n"

  if [ -d "${clonePath}" ];
  then
    printf "${YELLOW}SKIP: target directory \"${clonePath}\" already exists${NORMAL}\n"
    continue
  fi

  targetDir="`dirname ${clonePath}`"
  mkdir -p "${targetDir}"

  git clone --mirror $remoteUrl $clonePath

  rc=$?;
  if [[ $rc != 0 ]];
  then
    printf "${RED}ERROR: Git exited with code ${rc}${NORMAL}\n"
  fi
done
