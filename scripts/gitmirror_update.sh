#!/bin/bash

NORMAL='\033[0m'
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
    printf "Updating ${CYAN}${dir}${NORMAL}\n"
    git fetch -p
  fi

  popd > /dev/null
done
