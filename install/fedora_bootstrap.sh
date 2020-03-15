#!/bin/bash

# Last tested with Fedora 31.

set -ex

# Configure RPM Fusion nonfree (see https://rpmfusion.org/Configuration)
sudo dnf install \
  "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
  "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Add COPRs
sudo dnf copr enable gregw/i3desktop
sudo dnf copr enable audron/polybar
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
  i3lock \
  compton \
  feh \
  progress \
  make \
  smartmontools \
  socat \
  git-subtree \
  perl-Config-IniFiles \
  perl-Data-Dumper \
  perl-Capture-Tiny \
  lzop \
  mbuffer \
  mhash \
  pv \
  perl-Image-ExifTool \
  hddtemp \
  libtool \
  ncurses-devel \
  nnn \
  light \
  network-manager-applet

# Install some more things
./dotfiles/install/neovim.sh
./dotfiles/install/nerdfont_dejavusansmono.sh

# Install configs
./dotfiles/install/main_configs.sh install
./dotfiles/install/su.sh install
./dotfiles/install/desktop_environment_config.sh install || true

# Set shell
sudo usermod --shell /bin/zsh dan

# Detect sensors
sudo sensors-detect
