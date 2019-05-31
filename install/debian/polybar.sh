#!/bin/sh

set -x

REPO_DIR="/tmp/polybar"

sudo apt-get install \
  cmake \
  cmake-data \
  pkg-config \
  libcairo2-dev \
  libxcb1-dev \
  libxcb-util0-dev \
  libxcb-randr0-dev \
  python-xcbgen \
  xcb-proto \
  libxcb-image0-dev \
  libxcb-ewmh-dev \
  libxcb-icccm4-dev \
  libxcb-xkb-dev \
  libxcb-xrm-dev \
  libxcb-cursor-dev \
  libasound2-dev \
  libpulse-dev \
  i3-wm \
  libjsoncpp-dev \
  libmpdclient-dev \
  libcurl4-openssl-dev \
  libiw-dev \
  libnl-3-dev

git clone \
  --branch 3.2 \
  --recursive \
  https://github.com/jaagr/polybar \
  "$REPO_DIR"

mkdir -p "$REPO_DIR/build"
cd "$REPO_DIR/build" || exit

cmake ..
make -j "$(nproc)"

sudo make install
