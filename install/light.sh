#!/bin/sh

set -ex

ARCHIVE='light-1.2.tar.gz'

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

curl \
  --location \
  --output "${ARCHIVE}" \
  "https://github.com/haikarainen/light/releases/download/v1.2/$ARCHIVE"

tar \
  --extract \
  --gzip \
  --file $ARCHIVE

cd 'light-1.2'

./configure --with-udev='/etc/udev/rules.d/'
make -j "$(nproc)"

sudo make install

rm -rf "$TEMP_DIR"
