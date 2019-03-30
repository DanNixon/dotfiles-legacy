#!/bin/bash

C_RED='\033[0;31m'
C_YELLOW='\033[0;33m'
C_CYAN='\033[0;36m'
C_NONE='\033[0m'

if [ $# -lt 2 ]; then
  echo "Usage: archive.sh [data directory] [archive directory] (rsync arguments)"
  exit 1
fi

# State data driectory
data_dir="$1"
printf "${C_CYAN}Data directory: ${C_YELLOW}${data_dir}${C_NONE}\n"

# State backup directory
dest_dir=$2
printf "${C_CYAN}Archive destination directory: ${C_YELLOW}${dest_dir}${C_NONE}\n"

# State additional arguments
shift 2
rsync_args="$@"
printf "${C_CYAN}rsync arguments: ${C_YELLOW}${rsync_args}${C_NONE}\n"

# Warn if no dry run option was not specified
if [[ $rsync_args != *"--dry-run"* ]]; then
  printf "${C_RED}CAREFUL: You have NOT specified --dry-run !${C_NONE}\n"
fi

# Get confirmation
read -p "Is this OK? " -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  set -x
  rsync \
    -av \
    $rsync_args \
    --exclude "drop" \
    --exclude "misc_volatile" \
    --exclude "phone_camera" \
    --exclude "videos" \
    --exclude "virtual_machines" \
    "$data_dir" \
    "$dest_dir"
else
  exit 2
fi
