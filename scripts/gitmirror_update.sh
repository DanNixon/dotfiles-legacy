#!/bin/bash

NORMAL='\033[0m'
CYAN='\033[0;36m'

rootDir=$1

for dir in $rootDir/*/
do
  pushd $dir > /dev/null

  if [ `git rev-parse --is-bare-repository ` == "true" ]
  then
    printf "Updating ${CYAN}${dir}${NORMAL}\n"
    git fetch -p
  fi

  popd > /dev/null
done
