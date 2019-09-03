# Fedora setup

Last tested with Fedora 30.

- `git clone https://github.com/DanNixon/dotfiles.git`
- Configure [RPM Fusion](https://rpmfusion.org/) nonfree
- `sudo dnf update`
- `sudo dnf copr enable gregw/i3desktop`
- `sudo dnf copr enable mhartgring/polybar`
- `sudo dnf copr enable pschyska/alacritty`
- `sudo dnf install alacritty i3-gaps polybar rofi pcsc-lite pcsc-lite-ccid mpv`
- `./dotfiles/install/download_nerdfont_dejavusansmono.sh`
- `./dotfiles/install/neovim.sh`
- `./dotfiles/install/dotfiles/main.sh`
- `./dotfiles/install/dotfiles/su.sh`
- `./dotfiles/install/dotfiles/i3wm.sh`
- `sudo usermod --shell /bin/zsh dan`
