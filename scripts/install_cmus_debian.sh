#!/bin/bash

# Install dependencies
sudo apt-get install \
  curl \
  dh-autoreconf \
  libavformat-dev \
  libjack-dev \
  libmad0-dev \
  libncursesw5-dev \
  libnotify-dev \
  libopusfile-dev \
  libroar-dev \
  libsamplerate0-dev

# Download, build and install cmus
CMUS_VERSION=2.7.1
cd /tmp
curl -L -o cmus.tar.gz https://github.com/cmus/cmus/archive/v${CMUS_VERSION}.tar.gz
tar xf cmus.tar.gz
cd cmus-${CMUS_VERSION}
./configure
make -j`nproc`
sudo make install

# Download, build and install cmusfm
cd /tmp
curl -L -o cmusfm.tar.gz https://github.com/Arkq/cmusfm/archive/master.tar.gz
tar xf cmusfm.tar.gz
cd cmusfm-master
autoreconf --install
./configure --enable-libnotify
make -j`nproc`
sudo make install
