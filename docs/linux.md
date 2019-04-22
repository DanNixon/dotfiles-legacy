# Linux applications and tools

- Shell
  - [Fish](https://fishshell.com)
- Terminal emulator
  - [Alacritty](https://github.com/jwilm/alacritty)
- Text editor
  - [Neovim](https://neovim.io)
- Desktop environment
  - [i3](https://i3wm.org/)
  - [Polybar](https://github.com/jaagr/polybar)
  - [Rofi](https://github.com/DaveDavenport/rofi)
  - [Compton](https://github.com/chjj/compton)
- Web browsers
  - [Firefox](https://www.mozilla.org/firefox)
    - [Dark Reader](https://github.com/darkreader/darkreader)
    - [Decentraleyes](https://decentraleyes.org)
    - [HTTPS Everywhere](https://github.com/EFForg/https-everywhere)
    - [Octotree](https://github.com/ovity/octotree)
    - [Privacy Badger](https://github.com/EFForg/privacybadger)
    - [Privacy Settings](https://github.com/schomery/privacy-settings)
    - [Refined GitHub](https://github.com/sindresorhus/refined-github)
    - [uBlock](https://github.com/gorhill/uBlock)
  - [browsh](https://www.brow.sh)
- Media players
  - [mpd](https://www.musicpd.org/)
    - [ncmpcpp](https://rybczak.net/ncmpcpp/)
    - [mpc](https://www.musicpd.org/clients/mpc/)
    - [mpscribble](https://www.musicpd.org/clients/mpdscribble/)
  - [mpv](https://mpv.io)
- Remote access
  - [mosh](https://mosh.org)
  - [sshfs](https://github.com/libfuse/sshfs)
- File managment
  - [rsync](https://rsync.samba.org)
  - [Syncthing](https://syncthing.net)
- Fonts
  - DejaVuSansMono [NerdFont](https://nerdfonts.com)

## Themes

[base16](http://chriskempson.com/projects/base16/) themes I have used for a
reasonable amount of time (most recent first):

- `base16-eighties`
- `base16-chalk`

## Notes

- [Broadcom wireless not working on Ubuntu](https://ubuntuforums.org/showthread.php?t=2214110).
- List available fonts: `updmap-sys --listmaps`
- Reload `Xresources`: `xrdb ~/.Xresources`

### PGP smart card dependencies

- Debian/Ubuntu: `apt install scdaemon pcscd pcsc-tools`
- Fedora: `dnf install pcsc-lite pcsc-lite-ccid`

If needed, reader can be manually selected in `.gnupg/scdaemon.conf` using
`reader-port`.
