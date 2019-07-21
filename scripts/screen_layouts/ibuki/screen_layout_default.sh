#!/bin/bash

set -x

WORKSPACE=${1:-1}
echo "Workspace: $WORKSPACE"

HERE="$( cd "$(dirname "$0")" ; pwd -P )"
i3-msg "workspace $WORKSPACE; append_layout $HERE/i3_layout_default.json"

function launch_app {
  $1 &
  disown
}

launch_app alacritty
launch_app alacritty
launch_app alacritty
launch_app alacritty
launch_app alacritty
launch_app firefox
launch_app firefox
