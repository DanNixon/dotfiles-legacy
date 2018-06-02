#!/bin/bash

NORMAL='\033[0m'
RED='\033[0;31m'
CYAN='\033[0;36m'

rootDir="."

while getopts ":d: :r" opt
do
  case $opt in
    d)
      rootDir="${OPTARG}"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

rootDir="$(cd ${rootDir}; pwd)"
printf "Root directory: ${CYAN}${rootDir}${NORMAL}\n"

repos=`find ${rootDir} -type f -name HEAD`

for d in ${repos}
do
  dir="`dirname ${d}`"
  pushd ${dir} > /dev/null

  if [ "`git rev-parse --is-bare-repository`" == "true" ]
  then
    printf "${CYAN}${dir}${NORMAL}\n"
    git fetch -p

    rc=$?;
    if [[ $rc != 0 ]];
    then
      printf "${RED}ERROR: Git exited with code ${rc}${NORMAL}\n"
    fi
  fi

  popd > /dev/null
done
