#!/bin/sh

set -x

ARCHIVE="light-1.2.tar.gz"

cd /tmp

curl \
  --location \
  "https://github.com/haikarainen/light/releases/download/v1.2/$ARCHIVE"

tar \
  --extract \
  --gzip \
  --file $ARCHIVE

cd light-1.2

./configure.sh --with-udev="/etc/udev/rules.d/"
make -j `nproc`

sudo make install
