#!/bin/sh

REPO_DIR="/tmp/i3-gaps"

sudo apt-get install \
  libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
  libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
  libstartup-notification0-dev libxcb-randr0-dev \
  libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
  libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
  autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

git clone \
  --branch 4.16.1 \
  https://www.github.com/Airblader/i3 \
  "$REPO_DIR"

cd "$REPO_DIR"

autoreconf --force --install

mkdir -p "$REPO_DIR"/build
cd "$REPO_DIR"/build

../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j`nproc`

sudo make install
