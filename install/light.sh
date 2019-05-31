#!/bin/sh

set -x

ARCHIVE="light-1.2.tar.gz"

cd "/tmp" || exit

curl \
  --location \
  --output "${ARCHIVE}" \
  "https://github.com/haikarainen/light/releases/download/v1.2/$ARCHIVE"

tar \
  --extract \
  --gzip \
  --file $ARCHIVE

cd "light-1.2" || exit

./configure --with-udev="/etc/udev/rules.d/"
make -j "$(nproc)"

sudo make install
