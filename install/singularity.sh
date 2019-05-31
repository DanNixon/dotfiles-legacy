#!/bin/bash

# Partially based off the official documentation:
# https://www.sylabs.io/guides/3.0/user-guide/installation.html#download-and-install-singularity-from-a-release

set -x

# Set as needed
VERSION=3.1.0
GOPATH="$HOME/go"

mkdir -p "$GOPATH/src/github.com/sylabs"
cd "$GOPATH/src/github.com/sylabs" || exit

# Get and unpack release tarball
wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
tar -xzf singularity-${VERSION}.tar.gz

# Configure
cd "./singularity" || exit
./mconfig

# Build
cd "builddir" || exit
make -j "$(nproc)"

# Install
sudo make install
