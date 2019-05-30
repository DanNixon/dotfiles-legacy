#!/bin/bash

set -x

WORKSPACE=$1

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
i3-msg "workspace $WORKSPACE; append_layout $HERE/default.json"

function launch_app {
  $1 &
  disown
}

launch_app alacritty
launch_app alacritty
launch_app alacritty
launch_app alacritty
launch_app firefox
launch_app firefox
