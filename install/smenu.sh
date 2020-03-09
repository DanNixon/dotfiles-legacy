#!/bin/sh

set -ex

VERSION='0.9.15'

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

curl \
  --location \
  --output 'smenu.tar.gz' \
  "https://github.com/p-gen/smenu/archive/v$VERSION.tar.gz"

tar \
  --extract \
  --gzip \
  --file 'smenu.tar.gz'

cd "smenu-$VERSION"
./build.sh
sudo make install

rm -rf "$TEMP_DIR"
