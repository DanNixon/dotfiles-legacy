#!/bin/bash

# Last tested with Fedora 30.

set -ex

# Grab dotfiles
git clone 'https://github.com/DanNixon/dotfiles.git'

# Configure RPM Fusion nonfree (see https://rpmfusion.org/Configuration)
sudo dnf install \
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Add COPRs
sudo dnf copr enable gregw/i3desktop
sudo dnf copr enable mhartgring/polybar
sudo dnf copr enable pschyska/alacritty

# Update and install packages (trim this list down if need be)
sudo dnf update
sudo dnf install \
  alacritty \
  i3-gaps \
  polybar \
  rofi \
  zsh \
  pcsc-lite \
  pcsc-lite-ccid \
  mpv \
  jq \
  lm_sensors \
  xclip \
  i3lock

# Install some more things
./dotfiles/install/neovim.sh
./dotfiles/install/nerdfont_dejavusansmono.sh

# Install configs
./dotfiles/install/dotfiles/main.sh
./dotfiles/install/dotfiles/su.sh
./dotfiles/install/dotfiles/i3wm.sh

# Set shell
sudo usermod --shell /bin/zsh dan

# Detect sensors
sudo sensors-detect
