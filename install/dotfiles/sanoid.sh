#!/bin/bash

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
. "$HERE/conf.sh"

set -ex

sanoid_dir="$DOTFILES/third_party/sanoid"

# Copy executables
sudo cp \
  "$sanoid_dir/sanoid" \
  "$sanoid_dir/syncoid" \
  "$sanoid_dir/findoid" \
  "$sanoid_dir/sleepymutex" \
  '/usr/local/sbin'

# Create config dir
sudo mkdir -p '/etc/sanoid'

# Copy defaults
sudo cp \
  "$sanoid_dir/sanoid.defaults.conf" \
  '/etc/sanoid'

# Create empty config file
sudo touch '/etc/sanoid/sanoid.conf'
