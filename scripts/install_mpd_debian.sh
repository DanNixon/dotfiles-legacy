#!/bin/bash

VERSION_MM=0.21
VERSION_PATCH=4
VERSION="${VERSION_MM}.${VERSION_PATCH}"

# Install dependencies
sudo apt-get install \
  curl \
  python3-pip \
  ninja-build \
  g++ \
  libpcre3-dev \
  libmad0-dev libmpg123-dev libid3tag0-dev \
  libflac-dev libvorbis-dev libopus-dev \
  libadplug-dev libaudiofile-dev libsndfile1-dev libfaad-dev \
  libfluidsynth-dev libgme-dev libmikmod2-dev libmodplug-dev \
  libmpcdec-dev libwavpack-dev libwildmidi-dev \
  libsidplay2-dev libsidutils-dev libresid-builder-dev \
  libavcodec-dev libavformat-dev \
  libmp3lame-dev libtwolame-dev libshine-dev \
  libsamplerate0-dev libsoxr-dev \
  libbz2-dev libcdio-paranoia-dev libiso9660-dev libmms-dev \
  libzzip-dev \
  libcurl4-gnutls-dev libyajl-dev libexpat-dev \
  libasound2-dev libao-dev libjack-jackd2-dev libopenal-dev \
  libpulse-dev libshout3-dev \
  libsndio-dev \
  libmpdclient-dev \
  libnfs-dev libsmbclient-dev \
  libupnp-dev \
  libavahi-client-dev \
  libsqlite3-dev \
  libsystemd-dev libwrap0-dev \
  libgtest-dev \
  libboost-dev \
  libicu-dev
pip3 install meson

# Download mpd
cd /tmp
curl -L \
  -o mpd.tar.xz \
  https://www.musicpd.org/download/mpd/${VERSION_MM}/mpd-${VERSION}.tar.xz
tar xf mpd.tar.xz
cd mpd-${VERSION}

# Build mpd
meson . output/release --buildtype=debugoptimized -Db_ndebug=true
ninja -C output/release

# Install mpd
sudo ninja -C output/release install
